# Show ec2 ip
output aws_ec2_ip {
  value       = module.ec2_instances.public_ip_addresses
  sensitive   = false
  description = "EC2 IP"
}
