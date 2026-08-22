# ============================================================
# AWS ADAPTIVE HONEYPOT
# Decoy IAM
# ============================================================

resource "aws_iam_role" "honeypot" {
  name = "${var.project_name}-${var.environment}-honeypot-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-${var.environment}-honeypot-role"
    Component = "decoy"
  }
}

# ------------------------------------------------------------
# Systems Manager
# ------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "honeypot_ssm" {
  role       = aws_iam_role.honeypot.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ------------------------------------------------------------
# CloudWatch
# ------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "honeypot_cloudwatch" {
  role       = aws_iam_role.honeypot.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# ------------------------------------------------------------
# EC2 Instance Profile
# ------------------------------------------------------------

resource "aws_iam_instance_profile" "honeypot" {
  name = "${var.project_name}-${var.environment}-honeypot-profile"
  role = aws_iam_role.honeypot.name

  tags = {
    Name      = "${var.project_name}-${var.environment}-honeypot-profile"
    Component = "decoy"
  }
}