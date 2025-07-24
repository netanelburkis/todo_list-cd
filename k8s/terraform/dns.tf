data "aws_route53_zone" "mysite" {
  name         = var.url_site
}
data "kubernetes_service" "nginx_ingress_lb" {
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = helm_release.nginx_ingress.metadata.namespace
  }
}
resource "aws_route53_record" "ingress_record" {
  zone_id = data.aws_route53_zone.mysite.zone_id
  name    = "*.${var.url_site}" # Replace with your actual domain
  type    = "CNAME"
    ttl     = 300
    records = [data.kubernetes_service.nginx_ingress_lb.status[0].load_balancer[0].ingress[0].hostname]
    }