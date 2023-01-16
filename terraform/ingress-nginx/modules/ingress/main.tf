resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("${path.module}/manifests/ingress.${var.namespace}.yml"))
}