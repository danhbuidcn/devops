terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "ec2_instances" {
  source      = "./ec2_modules"
  subnet_id   = var.subnet_id
  instance_count = var.instance_count
  security_group_id = var.security_group_id
  key_pair_name = var.key_pair_name
}
