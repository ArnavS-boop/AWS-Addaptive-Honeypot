data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "honeypot" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = var.public_subnet_ids[0]

  vpc_security_group_ids = [
    var.honeypot_security_group_id
  ]

  iam_instance_profile = aws_iam_instance_profile.honeypot.name

  associate_public_ip_address = var.enable_public_ip

  user_data = templatefile("${path.module}/user_data.sh", {
    project_name = var.project_name
    environment  = var.environment
    persona      = var.default_persona
  })

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name      = "${var.project_name}-${var.environment}-honeypot-01"
    Component = "decoy"
    Role      = "honeypot"
  }
}

