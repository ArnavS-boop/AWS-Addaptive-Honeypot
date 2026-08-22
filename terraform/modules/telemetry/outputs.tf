output "telemetry_bucket_id" {
  description = "Telemetry S3 bucket ID."
  value       = aws_s3_bucket.telemetry.id
}

output "telemetry_bucket_arn" {
  description = "Telemetry S3 bucket ARN."
  value       = aws_s3_bucket.telemetry.arn
}

output "telemetry_bucket_name" {
  description = "Telemetry S3 bucket name."
  value       = aws_s3_bucket.telemetry.bucket
}