#!/bin/bash

set -euo pipefail

HONEYPOT_ROOT="/AWS-adaptive-honeypot/honeypots"

echo "Deploying adaptive honeypot stack..."

mkdir -p "${HONEYPOT_ROOT}"

echo "Honeypot runtime directory: ${HONEYPOT_ROOT}"

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not available."
    exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "Docker Compose is not available."
    exit 1
fi

echo "Docker:"
docker --version

echo "Docker Compose:"
docker compose version

echo "Honeypot deployment environment is ready."