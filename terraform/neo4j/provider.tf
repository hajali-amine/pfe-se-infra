data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "devops-project"
    container_name       = "cluster"
    storage_account_name = "terraformstatesdevops"
    key                  = "cluster.json"
  }

}

locals {
  kube_config            = one(data.terraform_remote_state.aks.outputs.kube_config)
  host                   = local.kube_config.host
  username               = local.kube_config.username
  password               = local.kube_config.password
  client_certificate     = base64decode(local.kube_config.client_certificate)
  client_key             = base64decode(local.kube_config.client_key)
  cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)
}

provider "helm" {
    kubernetes {
    host                   = local.host
    username               = local.username
    password               = local.password
    client_certificate     = local.client_certificate
    client_key             = local.client_key
    cluster_ca_certificate = local.cluster_ca_certificate
  }
}
