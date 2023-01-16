terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.16.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "devops-project"
    container_name       = "nginx"
    storage_account_name = "terraformstatesdevops"
    key                  = "nginx.json"
  }
}