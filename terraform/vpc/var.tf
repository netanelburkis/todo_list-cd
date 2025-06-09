variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "eu-central-1"
}

variable "vpc_cidr" {
    type        = string
    default     = "10.0.0.0/16"
}