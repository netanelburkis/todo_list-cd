variable "dns_address" {
  type        = string
}

variable "lb_dns_address" {
  type        = string
}

variable "zone_id" {
  type        = string
}   

variable "subdomain" {
  type        = string
  default     = "app"
}

variable "lb_name" {
  type        = string
}