resource "helm_release" "neo4j" {
  name       = "neo4j"
  repository = "https://helm.neo4j.com/neo4j"
  chart      = "neo4j-standalone"
  values = ["${file("values/neo4j.values.yml")}"]
}
