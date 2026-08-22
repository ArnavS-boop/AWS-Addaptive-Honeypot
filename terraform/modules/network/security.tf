# ============================================================
# AWS ADAPTIVE HONEYPOT
# Security Foundation
# ============================================================

# ------------------------------------------------------------
# Honeypot Security Group
#
# This is deliberately restrictive.
# Individual honeypot ports will be added later through
# dedicated rules as we implement each service.
# ------------------------------------------------------------

resource "aws_security_group" "honeypot" {
  name        = "${var.project_name}-${var.environment}-honeypot"
  description = "Security group for adaptive honeypot instances"
  vpc_id      = aws_vpc.main.id

  # Allow all outbound traffic.
  # The honeypot needs outbound connectivity for controlled
  # telemetry and management, while inbound access is
  # explicitly controlled below.
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.environment}-honeypot-sg"
    Component = "security"
  }
}

# ------------------------------------------------------------
# Management Security Group
#
# Management access will eventually be handled through SSM.
# We therefore intentionally do NOT open SSH to the Internet.
# ------------------------------------------------------------

resource "aws_security_group" "management" {
  name        = "${var.project_name}-${var.environment}-management"
  description = "Security group for controlled management access"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow outbound management traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.environment}-management-sg"
    Component = "security"
  }
}

# ------------------------------------------------------------
# Analytics Security Group
#
# Used later for OpenSearch and other internal analytics
# components.
# ------------------------------------------------------------

resource "aws_security_group" "analytics" {
  name        = "${var.project_name}-${var.environment}-analytics"
  description = "Security group for internal analytics services"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow outbound analytics traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-${var.environment}-analytics-sg"
    Component = "security"
  }
}