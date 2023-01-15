resource "helm_release" "es" {
  name       = "es"
  repository = "https://github.com/elastic/helm-charts"
  values     = ["${file("${path.module}/values/es.values.yml")}"]
  chart      = "elasticsearch"
  namespace  = var.namespace
}

resource "helm_release" "kibana" {
  name       = "es"
  repository = "https://github.com/elastic/helm-charts"
  chart      = "kibana"
  namespace  = var.namespace
}

