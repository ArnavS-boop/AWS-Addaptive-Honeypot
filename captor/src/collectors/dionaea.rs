use crate::models::{
    AttackEvent,
    Destination,
    Honeypot,
    Interaction,
    Source,
};

use anyhow::{Context, Result};
use chrono::Utc;
use serde::Deserialize;
use std::fs::File;
use std::io::{BufRead, BufReader};

#[derive(Debug, Deserialize)]
struct DionaeaEvent {
    connection: Option<DionaeaConnection>,
    src_ip: Option<String>,
    src_port: Option<u16>,
    dst_ip: Option<String>,
    dst_port: Option<u16>,
    src_hostname: Option<String>,
    timestamp: Option<String>,
}

#[derive(Debug, Deserialize)]
struct DionaeaConnection {
    protocol: Option<String>,
    transport: Option<String>,
    #[serde(rename = "type")]
    connection_type: Option<String>,
}

pub fn read_events(path: &str) -> Result<Vec<AttackEvent>> {
    let file = File::open(path)
        .with_context(|| format!("unable to open Dionaea log: {path}"))?;

    let reader = BufReader::new(file);
    let mut events = Vec::new();

    for (line_number, line) in reader.lines().enumerate() {
        let line = line
            .with_context(|| format!("failed reading line {}", line_number + 1))?;

        if line.trim().is_empty() {
            continue;
        }

        match serde_json::from_str::<DionaeaEvent>(&line) {
            Ok(raw) => {
                if let Some(event) = normalize_event(raw) {
                    events.push(event);
                }
            }

            Err(error) => {
                eprintln!(
                    "[captor] skipping invalid Dionaea JSON at line {}: {}",
                    line_number + 1,
                    error
                );
            }
        }
    }

    Ok(events)
}

fn normalize_event(raw: DionaeaEvent) -> Option<AttackEvent> {
    let connection = raw.connection?;

    let src_ip = raw.src_ip?;
    let dst_port = raw.dst_port?;

    let protocol = connection
        .protocol
        .unwrap_or_else(|| "unknown".to_string());

    let action = connection.connection_type;

    let service = match protocol.to_lowercase().as_str() {
        "httpd" => Some("http".to_string()),
        "ftp" => Some("ftp".to_string()),
        "smb" => Some("smb".to_string()),
        "mysql" => Some("mysql".to_string()),
        "mqttd" => Some("mqtt".to_string()),
        "memcache" => Some("memcache".to_string()),
        "sip" => Some("sip".to_string()),
        _ => Some(protocol.clone()),
    };

    Some(AttackEvent {
        event_id: uuid::Uuid::new_v4(),

        timestamp: raw
            .timestamp
            .and_then(|timestamp| {
                chrono::DateTime::parse_from_rfc3339(&timestamp)
                    .ok()
                    .map(|dt| dt.with_timezone(&Utc))
            })
            .unwrap_or_else(Utc::now),

        source: Source {
            ip: src_ip,
            port: raw.src_port,
        },

        destination: Destination {
            honeypot_id: "dionaea-01".to_string(),
            service,
            port: Some(dst_port),
        },

        honeypot: Honeypot {
            honeypot_type: "dionaea".to_string(),
            version: Some("0.11.0".to_string()),
            persona: "generic-linux-server".to_string(),
        },

        interaction: Interaction {
            session_id: None,
            protocol,
            action,
            command: None,
            request: raw.src_hostname,
        },

        classification: None,
        mitre: None,
        risk: None,
        response: None,
    })
}