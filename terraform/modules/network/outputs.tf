output "vpc_id" {
  description = "ID of the Adaptive Honeypot VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the Adaptive Honeypot VPC."
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  description = "IDs of private subnets."
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "honeypot_security_group_id" {
  description = "Security group for honeypot instances."
  value       = aws_security_group.honeypot.id
}

output "management_security_group_id" {
  description = "Security group for management resources."
  value       = aws_security_group.management.id
}

output "analytics_security_group_id" {
  description = "Security group for analytics resources."
  value       = aws_security_group.analytics.id
}