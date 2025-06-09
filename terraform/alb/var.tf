variable "vpc_id" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)  
}

variable "instance_id" {
  type        = list(string)
}

variable "alb_name" {
  type        = string
  default     = "my-app-alb"
}