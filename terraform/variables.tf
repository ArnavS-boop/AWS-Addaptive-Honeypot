variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "demo"], var.environment)
    error_message = "Environment must be either dev or demo."
  }
}

variable "aws_region" {
  description = "AWS deployment region."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the main VPC."
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A."
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B."
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A."
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet B."
  type        = string
}
variable "decoy_instance_type" {
  description = "EC2 instance type used for the honeypot."
  type        = string
}

variable "decoy_root_volume_size" {
  description = "Root volume size for honeypot EC2 instances in GiB."
  type        = number
}

variable "decoy_enable_public_ip" {
  description = "Whether honeypot instances receive public IPv4 addresses."
  type        = bool
}

variable "default_decoy_persona" {
  description = "Initial persona presented by a newly deployed honeypot."
  type        = string
}