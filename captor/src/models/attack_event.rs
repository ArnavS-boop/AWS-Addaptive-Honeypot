use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AttackEvent {
    pub event_id: Uuid,
    pub timestamp: DateTime<Utc>,

    pub source: Source,
    pub destination: Destination,
    pub honeypot: Honeypot,
    pub interaction: Interaction,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub classification: Option<Classification>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub mitre: Option<Mitre>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub risk: Option<Risk>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub response: Option<Response>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Source {
    pub ip: String,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub port: Option<u16>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Destination {
    pub honeypot_id: String,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub service: Option<String>,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub port: Option<u16>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Honeypot {
    #[serde(rename = "type")]
    pub honeypot_type: String,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub version: Option<String>,

    pub persona: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Interaction {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub session_id: Option<String>,

    pub protocol: String,

    #[serde(skip_serializing_if = "Option::is_none")]
    pub action: Option<String>,

    pub command: Option<String>,
    pub request: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Classification {
    pub attack_type: Option<String>,
    pub confidence: Option<f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Mitre {
    pub tactic: Option<String>,
    pub technique: Option<String>,
    pub subtechnique: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Risk {
    pub score: Option<f64>,
    pub severity: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Response {
    pub action: Option<String>,
    pub persona_before: Option<String>,
    pub persona_after: Option<String>,
}