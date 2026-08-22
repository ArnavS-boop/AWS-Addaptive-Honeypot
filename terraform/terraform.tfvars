project_name = "AWS-Adaptive-Honeypot"

environment = "dev"

aws_region = "ap-south-1"

vpc_cidr = "10.50.0.0/16"

public_subnet_a_cidr = "10.50.1.0/24"

public_subnet_b_cidr = "10.50.2.0/24"

private_subnet_a_cidr = "10.50.11.0/24"

private_subnet_b_cidr = "10.50.12.0/24"

decoy_instance_type    = "t3.micro"
decoy_root_volume_size = 20
decoy_enable_public_ip = true

default_decoy_persona = "enterprise-linux"