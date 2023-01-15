terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "devops-project"
    container_name       = "rabbitmq-operator"
    storage_account_name = "terraformstatesdevops"
    key                  = "rabbitmq-operator.json"
  }
}