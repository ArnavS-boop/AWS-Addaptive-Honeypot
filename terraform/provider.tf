provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Project     = "AWS-Adaptive-Honeypot"
      ManagedBy   = "Terraform"
      Environment = "dev"
    }
  }
}