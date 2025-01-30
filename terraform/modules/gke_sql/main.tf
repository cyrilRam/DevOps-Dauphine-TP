provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Secret pour MySQL
resource "kubernetes_secret" "mysql_secret" {
  metadata {
    name = "mysql-secret"
  }

  data = {
    MYSQL_ROOT_PASSWORD = var.mysql_root_password
    MYSQL_USER          = var.mysql_user
    MYSQL_PASSWORD      = var.mysql_password
    MYSQL_DATABASE      = "wordpress"
  }
}

#Persistent Volume Claim pour MySQL
# resource "kubernetes_persistent_volume_claim" "mysql_pvc" {
#   metadata {
#     name = "mysql-pvc"
#   }
#
#   spec {
#     access_modes = ["ReadWriteOnce"]
#
#     resources {
#       requests = {
#         storage = "10Gi"
#       }
#     }
#   }
# }

# Déploiement de MySQL
resource "kubernetes_stateful_set" "mysql" {
  metadata {
    name = "mysql"
  }

  spec {
    service_name = "mysql"
    replicas     = 1

    selector {
      match_labels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          image = "mysql:5.7"
          name  = "mysql"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "MYSQL_ROOT_PASSWORD"
              }
            }
          }

          env {
            name = "MYSQL_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "MYSQL_USER"
              }
            }
          }

          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "MYSQL_PASSWORD"
              }
            }
          }

          env {
            name = "MYSQL_DATABASE"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql_secret.metadata[0].name
                key  = "MYSQL_DATABASE"
              }
            }
          }

          port {
            container_port = 3306
          }

          # volume_mount {
          #   mount_path = "/var/lib/mysql"
          #   name       = "mysql-storage"
          # }
        }

        # volume {
        #   name = "mysql-storage"
        #
        #   persistent_volume_claim {
        #     claim_name = kubernetes_persistent_volume_claim.mysql_pvc.metadata[0].name
        #   }
        # }
      }
    }
  }
}

# Service pour MySQL
resource "kubernetes_service" "mysql" {
  metadata {
    name = "mysql"
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }
  }
}
