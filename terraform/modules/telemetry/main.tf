# ============================================================
# AWS ADAPTIVE HONEYPOT
# Telemetry Module
# ============================================================

# ------------------------------------------------------------
# S3 bucket
#
# This is the durable source of truth for telemetry.
# OpenSearch will later be treated as a searchable projection,
# not the authoritative datastore.
# ------------------------------------------------------------

resource "aws_s3_bucket" "telemetry" {
  bucket = "${lower(var.project_name)}-${var.environment}-telemetry"

  force_destroy = var.force_destroy

  tags = {
    Name      = "${var.project_name}-${var.environment}-telemetry"
    Component = "telemetry"
    DataRole  = "source-of-truth"
  }
}

# ------------------------------------------------------------
# Block public access
# ------------------------------------------------------------

resource "aws_s3_bucket_public_access_block" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------------------------------------------------------------
# Versioning
#
# Protects against accidental overwrites/deletions.
# ------------------------------------------------------------

resource "aws_s3_bucket_versioning" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ------------------------------------------------------------
# Server-side encryption
# ------------------------------------------------------------

resource "aws_s3_bucket_server_side_encryption_configuration" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ------------------------------------------------------------
# Lifecycle management
#
# Raw telemetry is retained, but old non-current object
# versions can eventually be cleaned up.
# ------------------------------------------------------------

resource "aws_s3_bucket_lifecycle_configuration" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

# ------------------------------------------------------------
# Event folders
#
# S3 does not have real directories. These zero-byte objects
# establish the logical structure we want for the project.
# ------------------------------------------------------------

resource "aws_s3_object" "raw" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/"
  content = ""
}

resource "aws_s3_object" "normalized" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "normalized/"
  content = ""
}

resource "aws_s3_object" "classified" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "classified/"
  content = ""
}

resource "aws_s3_object" "mitre" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "mitre/"
  content = ""
}

resource "aws_s3_object" "responses" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "responses/"
  content = ""
}

resource "aws_s3_object" "athena_results" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "athena-results/"
  content = ""
}

resource "aws_s3_object" "raw_cowrie" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/cowrie/"
  content = ""
}

resource "aws_s3_object" "raw_dionaea" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/dionaea/"
  content = ""
}

resource "aws_s3_object" "raw_h0neytr4p" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/h0neytr4p/"
  content = ""
}

resource "aws_s3_object" "raw_web" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/web/"
  content = ""
}

resource "aws_s3_object" "raw_vpc_flow" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "raw/vpc-flow/"
  content = ""
}
resource "aws_s3_object" "normalized_attacks" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "normalized/attacks/"
  content = ""
}

resource "aws_s3_object" "classified_attacks" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "classified/attacks/"
  content = ""
}

resource "aws_s3_object" "mitre_attacks" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "mitre/attacks/"
  content = ""
}

resource "aws_s3_object" "response_events" {
  bucket  = aws_s3_bucket.telemetry.id
  key     = "responses/events/"
  content = ""
}