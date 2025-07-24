
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace  = "argocd"
  create_namespace = true

  set = [
    {
    name  = "server.ingress.enabled"
    value = "true"
  },
  {
    name  = "server.ingress.ingressClassName"
    value = "nginx" # Ensure this matches your ingress controller class
  },

   {
    name  = "server.ingress.hostname"
    value = "argocd.netanelbukris.site" # Replace with your actual domain
  },
  {
      name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/backend-protocol"
      value = "HTTPS"
  }
  ]
  depends_on = [module.eks, helm_release.nginx_ingress]
}
data "kubernetes_secret" "argocd_admin_password" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = helm_release.argocd.metadata.namespace
  }
}
output "argocd_admin_password" {
  value     = data.kubernetes_secret.argocd_admin_password.data["password"]
  sensitive = true
  
}


resource "kubernetes_manifest" "root-app" {
  manifest = yamldecode(file("../argo/root-app.yaml"))
  depends_on = [helm_release.argocd, module.eks]
}