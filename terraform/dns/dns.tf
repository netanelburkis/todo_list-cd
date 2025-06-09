data "aws_route53_zone" "main" {
  name = var.dns_address
    private_zone = false
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.subdomain}.${var.dns_address}"
  type    = "A"

  alias {
    name                   = var.lb_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}