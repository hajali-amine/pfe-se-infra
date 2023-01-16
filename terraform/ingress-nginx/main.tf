resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  set {
    name = "controller.resources.requests.cpu"
    value = "50m"
  }  
  set {
    name = "controller.resources.requests.memory"
    value = "50Mi"
  }
}

module "ingress-dev" {
  source = "./modules/ingress"
  providers = {
    kubernetes = kubernetes
   }
  namespace = "dev"
}
module "ingress-prod" {
  source = "./modules/ingress"
  providers = {
    kubernetes = kubernetes
   }
  namespace = "prod"
}
module "ingress-qa" {
  source = "./modules/ingress"
  providers = {
    kubernetes = kubernetes
   }
  namespace = "qa"
}
module "ingress-monitoring" {
  source = "./modules/ingress"
  providers = {
    kubernetes = kubernetes
   }
  namespace = "monitoring-v2"
}