output "ec2_private_ip" {
  value = [for instance in aws_instance.ec2_instance : instance.private_ip]
}

output "ec2_id" {
  value = [for instance in aws_instance.ec2_instance : instance.id]
}