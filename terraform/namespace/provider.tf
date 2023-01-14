data "terraform_remote_state" "aks" {
  backend = "local"

  config = {
    path = "../cluster/terraform.tfstate"
  }
}

# locals {
#   kube_config            = one(data.terraform_remote_state.aks.outputs.config)
#   host                   = local.kube_config.host
#   username               = local.kube_config.username
#   password               = local.kube_config.password
#   client_certificate     = base64decode(local.kube_config.client_certificate)
#   client_key             = base64decode(local.kube_config.client_key)
#   cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)
# }

provider "kubernetes" {
  config_path    = "../cluster/test-cluster-config"
}
