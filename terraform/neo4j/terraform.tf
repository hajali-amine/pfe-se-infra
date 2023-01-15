terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "devops-project"
    container_name       = "neo4j"
    storage_account_name = "terraformstatesdevops"
    key                  = "neo4j.json"
  }
}