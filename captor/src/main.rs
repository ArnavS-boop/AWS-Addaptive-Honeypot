mod collectors;
mod models;

use anyhow::Result;
use collectors::dionaea::read_events;

fn main() -> Result<()> {
    let path = "../honeypots/dionaea/var/lib/dionaea/dionaea.json";

    println!("[captor] reading Dionaea telemetry from {path}");

    let events = read_events(path)?;

    println!("[captor] loaded {} Dionaea events", events.len());

    for event in events {
        println!(
            "{}",
            serde_json::to_string(&event)?
        );
    }

    Ok(())
}