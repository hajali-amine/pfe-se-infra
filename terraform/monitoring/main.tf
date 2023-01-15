resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "monitoring-v2"
  }
}

module "prometheus" {
  source = "./modules/prometheus"
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
  namespace = kubernetes_namespace.namespace.id
}

module "signoz" {
  source = "./modules/signoz"
  providers = {
    helm = helm
  }
  namespace = kubernetes_namespace.namespace.id
}