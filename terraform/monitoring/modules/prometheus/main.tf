resource "helm_release" "prometheus" {
  name       = "prometheus-grafana"
  repository = "https://prometheus-community.github.io/helm-charts"
  values     = ["${file("${path.module}/values/prometheus.values.yml")}"]
  chart      = "prometheus"
  namespace  = var.namespace
}

resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.namespace
    labels = {
      app = "grafana"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "grafana"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }
      spec {
        container {
          image = "grafana/grafana:9.1.0"
          name  = "grafana"
          port {
            container_port = 3000
            name           = "http-grafana"
            protocol       = "TCP"
          }
          resources {
            requests = {
              cpu    = "50m"
              memory = "50Mi"
            }
          }
          volume_mount {
            name       = "config-provisioning"
            mount_path = "/etc/grafana/provisioning/datasources/datasources.yml"
            sub_path   = "datasources.yml"
          }
          volume_mount {
            name       = "config-provisioning"
            mount_path = "/etc/grafana/provisioning/dashboards/dashboards.yml"
            sub_path   = "dashboards.yml"
          }
          volume_mount {
            name       = "config-dashboards"
            mount_path = "/etc/grafana/dashboards/node-exporter/node-exporter.json"
            sub_path   = "node-exporter.json"
          }
          volume_mount {
            name       = "config-dashboards"
            mount_path = "/etc/grafana/dashboards/search-engine/search.json"
            sub_path   = "search.json"
          }
        }
        volume {
          name = "config-provisioning"
          config_map {
            name = kubernetes_config_map.grafana_config.metadata.0.name
          }
        }
        volume {
          name = "config-dashboards"
          config_map {
            name = kubernetes_config_map.grafana_dashboard.metadata.0.name
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment.grafana.metadata.0.labels.app
    }
    port {
      port        = 3000
      target_port = 3000
    }

  }
}

resource "kubernetes_config_map" "grafana_config" {
  metadata {
    name      = "config-provisioning"
    namespace = var.namespace
  }

  data = {
    "datasources.yml" = "${file("${path.module}/files/datasources.yml")}"
    "dashboards.yml"  = "${file("${path.module}/files/dashboards.yml")}"
  }
}

resource "kubernetes_config_map" "grafana_dashboard" {
  metadata {
    name      = "config-dashboards"
    namespace = var.namespace
  }

  data = {
    "node-exporter.json" = "${file("${path.module}/files/node-exporter.json")}"
    "search.json" = "${file("${path.module}/files/search.json")}"
  }
}
