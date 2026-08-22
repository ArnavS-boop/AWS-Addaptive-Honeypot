output "honeypot_instance_id" {
  description = "EC2 instance ID of the honeypot."
  value       = aws_instance.honeypot.id
}

output "honeypot_private_ip" {
  description = "Private IP address of the honeypot."
  value       = aws_instance.honeypot.private_ip
}

output "honeypot_public_ip" {
  description = "Public IP address of the honeypot."
  value       = aws_instance.honeypot.public_ip
}

output "honeypot_ami_id" {
  description = "AMI ID used by the honeypot."
  value       = data.aws_ami.amazon_linux.id
}