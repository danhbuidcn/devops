terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = { 
    Name = "terraform-demo"
    env  = "dev"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.aws_availability_zone
  map_public_ip_on_launch = true

  tags = { 
    Name = "public-subnet"
    env  = "dev"
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.aws_availability_zone

  tags = { 
    Name = "private-subnet"
    env  = "dev"
  }
}

output aws_vpc_id {
  value       = aws_vpc.example
  sensitive   = true
  description = "ID of the above VPC"
}