resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "monitoring"
  }
}

module "prometheus" {
  source = "./modules/prometheus"
  providers = {
    helm = helm
  }
  namespace = kubernetes_namespace.namespace.id
}

module "jaeger" {
  source = "./modules/jaeger"
  providers = {
    helm = helm
  }
  namespace = kubernetes_namespace.namespace.id
}