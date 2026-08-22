#!/bin/bash

set -euxo pipefail

LOG_FILE="/var/log/adaptive-honeypot-bootstrap.log"

exec > >(tee -a "${LOG_FILE}" | logger -t adaptive-honeypot-bootstrap -s 2>/dev/console) 2>&1

echo "============================================================"
echo " AWS Adaptive Honeypot - EC2 Bootstrap"
echo "============================================================"

# ------------------------------------------------------------
# Configuration supplied by Terraform
# ------------------------------------------------------------

PROJECT_NAME="${project_name}"
ENVIRONMENT="${environment}"
DEFAULT_PERSONA="${persona}"

APP_ROOT="/opt/adaptive-honeypot"

echo "Project: ${PROJECT_NAME}"
echo "Environment: ${ENVIRONMENT}"
echo "Default persona: ${DEFAULT_PERSONA}"

# ------------------------------------------------------------
# System update
# ------------------------------------------------------------

echo "[1/7] Updating system..."

dnf update -y

# ------------------------------------------------------------
# Required packages
# ------------------------------------------------------------

echo "[2/7] Installing required packages..."

dnf install -y \
  docker \
  git \
  jq \
  curl \
  unzip

# ------------------------------------------------------------
# Docker
# ------------------------------------------------------------

echo "[3/7] Configuring Docker..."

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

# ------------------------------------------------------------
# Docker Compose
# ------------------------------------------------------------

echo "[4/7] Verifying Docker Compose..."

if docker compose version >/dev/null 2>&1; then
    echo "Docker Compose plugin already available."
else
    echo "Docker Compose plugin not available."
    echo "This will be installed explicitly later if required."
fi

# ------------------------------------------------------------
# SSM Agent
# ------------------------------------------------------------

echo "[5/7] Configuring SSM Agent..."

if systemctl list-unit-files | grep -q amazon-ssm-agent; then
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    echo "SSM Agent configured."
else
    echo "WARNING: amazon-ssm-agent service not found."
fi

# ------------------------------------------------------------
# Application directory structure
# ------------------------------------------------------------

echo "[6/7] Creating application directories..."

mkdir -p "${APP_ROOT}"

mkdir -p "${APP_ROOT}/honeypots"
mkdir -p "${APP_ROOT}/personas"
mkdir -p "${APP_ROOT}/manager"
mkdir -p "${APP_ROOT}/config"
mkdir -p "${APP_ROOT}/logs"

chown -R ec2-user:ec2-user "${APP_ROOT}"

# ------------------------------------------------------------
# Initial runtime configuration
# ------------------------------------------------------------

echo "[7/7] Creating runtime configuration..."

cat > "${APP_ROOT}/config/runtime.json" <<EOF
{
  "project": "${PROJECT_NAME}",
  "environment": "${ENVIRONMENT}",
  "persona": "${DEFAULT_PERSONA}",
  "status": "initialized"
}
EOF

cat > "${APP_ROOT}/config/bootstrap.json" <<EOF
{
  "project": "${PROJECT_NAME}",
  "environment": "${ENVIRONMENT}",
  "bootstrap_completed": true,
  "docker": true,
  "ssm": true
}
EOF

chown -R ec2-user:ec2-user "${APP_ROOT}"

echo "============================================================"
echo " Bootstrap completed successfully"
echo " Application root: ${APP_ROOT}"
echo "============================================================"