# ============================================================
# AWS ADAPTIVE HONEYPOT
# Network ACL Foundation
# ============================================================

# ------------------------------------------------------------
# Public NACL
#
# The honeypot subnet is intentionally exposed, but the
# subnet-level rules remain explicit.
# ------------------------------------------------------------

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.environment}-public-nacl"
    Component = "security"
    Tier      = "public"
  }
}

# ------------------------------------------------------------
# Public inbound
# ------------------------------------------------------------

resource "aws_network_acl_rule" "public_ingress" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# ------------------------------------------------------------
# Public outbound
# ------------------------------------------------------------

resource "aws_network_acl_rule" "public_egress" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# ------------------------------------------------------------
# Associate public NACL with public subnets
# ------------------------------------------------------------

resource "aws_network_acl_association" "public_a" {
  network_acl_id = aws_network_acl.public.id
  subnet_id      = aws_subnet.public_a.id
}

resource "aws_network_acl_association" "public_b" {
  network_acl_id = aws_network_acl.public.id
  subnet_id      = aws_subnet.public_b.id
}

# ------------------------------------------------------------
# Private NACL
# ------------------------------------------------------------

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.environment}-private-nacl"
    Component = "security"
    Tier      = "private"
  }
}

resource "aws_network_acl_rule" "private_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}

resource "aws_network_acl_rule" "private_egress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
}

# ------------------------------------------------------------
# Associate private NACL with private subnets
# ------------------------------------------------------------

resource "aws_network_acl_association" "private_a" {
  network_acl_id = aws_network_acl.private.id
  subnet_id      = aws_subnet.private_a.id
}

resource "aws_network_acl_association" "private_b" {
  network_acl_id = aws_network_acl.private.id
  subnet_id      = aws_subnet.private_b.id
}