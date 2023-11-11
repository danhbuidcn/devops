
variable "subnet_id" {}
variable "instance_count" {}
variable "security_group_id" {}
variable "key_pair_name" {}


data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_pair_name
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "EC2 Instance ${count.index + 1}"
  }
}

output "public_ip_addresses" {
  value = aws_instance.ec2_instance[*].public_ip
}