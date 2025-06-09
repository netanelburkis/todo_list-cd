variable "aws_region" {
  type        = string
  default     = "eu-central-1"
}

variable "dns_address" {
  type        = string
}

variable "ami_id" {
  type        = string
  default     = "ami-03250b0e01c28d196"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_instance_count" {
  type        = number
  default     = 1
}

variable "app_port" {
  type        = number
}