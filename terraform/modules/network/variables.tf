variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the Adaptive Honeypot VPC."
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