terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.16.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "devops-project"
    container_name       = "namespace"
    storage_account_name = "terraformstatesdevops"
    key                  = "namespace.json"
  }
}