resource "helm_release" "prometheus" {
  name       = "prometheus-grafana"
  repository = "https://prometheus-community.github.io/helm-charts"
  values = ["${file("${path.module}/values/prometheus.values.yml")}"]
  chart      = "kube-prometheus-stack"
  namespace = var.namespace
}

# TODO: change grafan default password and user
