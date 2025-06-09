provider "aws" {
  region = var.aws_region 
}

resource "aws_instance" "ec2_instance" {
  count         = var.count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  vpc_security_group_ids = aws_security_group.ec2_sg.id
  tags = merge(
    {
      "Name" = "${var.ec2_name}-${count.index + 1}"
    },
    var.tags
  )
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = var.sg_name
  description = "Security group for ${var.ec2_name} instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port_to_open
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.address_to_open]
  }

  ingress {
    from_port   = var.port_to_open
    to_port     = var.port_to_open
    protocol    = "tcp"
    cidr_blocks = [var.address_to_open]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}