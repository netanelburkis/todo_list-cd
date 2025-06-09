variable "aws_region" {
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"   
}

variable "ami_id" {
  type        = string
  default     = "ami-03250b0e01c28d196"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  type        = list(string)
}

variable "count" {
  type        = number
  default     = 1
}

variable "sg_name" {
  type        = string
}

variable "ec2_name" {
  type        = string
  default     = "my-ec2-instance" 
}

variable "vpc_id" {
  type        = string
}

variable "port_to_open" {
  type        = number
}

variable "address_to_open" {
  type        = string
}