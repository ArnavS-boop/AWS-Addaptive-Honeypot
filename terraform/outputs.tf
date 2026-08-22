output "vpc_id" {
  description = "Adaptive Honeypot VPC ID."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Adaptive Honeypot public subnet IDs."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Adaptive Honeypot private subnet IDs."
  value       = module.network.private_subnet_ids
}

output "honeypot_security_group_id" {
  description = "Honeypot security group ID."
  value       = module.network.honeypot_security_group_id
}

output "analytics_security_group_id" {
  description = "Analytics security group ID."
  value       = module.network.analytics_security_group_id
}
output "telemetry_bucket_name" {
  description = "Telemetry S3 bucket name."
  value       = module.telemetry.telemetry_bucket_name
}

output "telemetry_bucket_arn" {
  description = "Telemetry S3 bucket ARN."
  value       = module.telemetry.telemetry_bucket_arn
}