module "network" {
  source = "./modules/network"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  vpc_cidr              = var.vpc_cidr
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}
module "telemetry" {
  source = "./modules/telemetry"

  project_name  = var.project_name
  environment   = var.environment
  force_destroy = false
}

module "decoy" {
  source = "./modules/decoy"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

  honeypot_security_group_id = module.network.honeypot_security_group_id

  instance_type    = var.decoy_instance_type
  root_volume_size = var.decoy_root_volume_size
  enable_public_ip = var.decoy_enable_public_ip

  default_persona = var.default_decoy_persona
}