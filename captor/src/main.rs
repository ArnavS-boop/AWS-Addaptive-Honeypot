mod models;

use chrono::Utc;
use models::*;
use uuid::Uuid;

fn main() {
    let event = AttackEvent {
        event_id: Uuid::new_v4(),
        timestamp: Utc::now(),

        source: Source {
            ip: "172.18.0.1".to_string(),
            port: Some(52374),
        },

        destination: Destination {
            honeypot_id: "dionaea-01".to_string(),
            service: Some("http".to_string()),
            port: Some(80),
        },

        honeypot: Honeypot {
            honeypot_type: "dionaea".to_string(),
            version: Some("0.11.0".to_string()),
            persona: "generic-linux-server".to_string(),
        },

        interaction: Interaction {
            session_id: None,
            protocol: "http".to_string(),
            action: Some("connection".to_string()),
            command: None,
            request: Some("GET /".to_string()),
        },

        classification: None,
        mitre: None,
        risk: None,
        response: None,
    };

    println!(
        "{}",
        serde_json::to_string_pretty(&event)
            .expect("failed to serialize attack event")
    );
}