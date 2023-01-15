resource "helm_release" "jaeger" {
  name       = "jaeger"
  repository = "https://charts.signoz.io"
  # values     = ["${file("${path.module}/values/jaeger.values.yml")}"]
  chart      = "signoz"
  namespace  = var.namespace
}

