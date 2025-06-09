output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_hosted_zone_id" {
  value = aws_lb.alb.hosted_zone_id
}

output "alb_name" {
  value = aws_lb.alb.name
}