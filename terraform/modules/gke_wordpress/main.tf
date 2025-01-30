provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Déploiement WordPress
resource "kubernetes_deployment" "gke_wordpress" {
  metadata {
    name = "wordpress"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "wordpress"
      }
    }

    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }

      spec {
        container {
          image = "wordpress:latest"
          name  = "wordpress"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = var.mysql_service_name
          }

          env {
            name = "WORDPRESS_DB_USER"
            value_from {
              secret_key_ref {
                name = var.mysql_secret_name
                key  = "MYSQL_USER"
              }
            }
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = var.mysql_secret_name
                key  = "MYSQL_PASSWORD"
              }
            }
          }

           env {
            name = "WORDPRESS_DB_NAME"
            value = "wordpress"

            }



          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service WordPress
resource "kubernetes_service" "gke_wordpress" {
  metadata {
    name = "wordpress"
  }

  spec {
    selector = {
      app = "wordpress"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
