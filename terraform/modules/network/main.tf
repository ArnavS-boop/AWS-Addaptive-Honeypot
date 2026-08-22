# ============================================================
# AWS ADAPTIVE HONEYPOT
# Step 1: VPC Foundation
# ============================================================

# ------------------------------------------------------------
# VPC
# ------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.project_name}-${var.environment}-vpc"
    Component = "network"
  }
}

# ------------------------------------------------------------
# Internet Gateway
# ------------------------------------------------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.environment}-igw"
    Component = "network"
  }
}

# ------------------------------------------------------------
# Public Subnet A
# ------------------------------------------------------------

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.project_name}-${var.environment}-public-a"
    Component = "network"
    Tier      = "public"
  }
}

# ------------------------------------------------------------
# Public Subnet B
# ------------------------------------------------------------

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.project_name}-${var.environment}-public-b"
    Component = "network"
    Tier      = "public"
  }
}

# ------------------------------------------------------------
# Private Subnet A
# ------------------------------------------------------------

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name      = "${var.project_name}-${var.environment}-private-a"
    Component = "network"
    Tier      = "private"
  }
}

# ------------------------------------------------------------
# Private Subnet B
# ------------------------------------------------------------

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name      = "${var.project_name}-${var.environment}-private-b"
    Component = "network"
    Tier      = "private"
  }
}

# ------------------------------------------------------------
# Public Route Table
# ------------------------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.environment}-public-rt"
    Component = "network"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# ------------------------------------------------------------
# Public Route Table Associations
# ------------------------------------------------------------

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# ------------------------------------------------------------
# Private Route Table
# ------------------------------------------------------------

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-${var.environment}-private-rt"
    Component = "network"
  }
}

# ------------------------------------------------------------
# Private Route Table Associations
# ------------------------------------------------------------

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}   