variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "VPC where the honeypot will run."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs available to the honeypot."
  type        = list(string)
}

variable "honeypot_security_group_id" {
  description = "Security group assigned to honeypot instances."
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type for the honeypot."
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size in GiB."
  type        = number
}

variable "enable_public_ip" {
  description = "Whether the honeypot receives a public IPv4 address."
  type        = bool
}

variable "default_persona" {
  description = "Initial persona assigned to the honeypot."
  type        = string
}
