terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.0.13"
    }
  }
}

provider "kind" {}

# Create a cluster with kind of the name "test-cluster" with kubernetes version v1.16.1
resource "kind_cluster" "default" {
    name = "test-cluster"
}

output "config" {
  value = kind_cluster.default.kubeconfig
}