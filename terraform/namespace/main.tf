resource "kubernetes_namespace" "namespace" {
  metadata {
    name = terraform.workspace
  }
}