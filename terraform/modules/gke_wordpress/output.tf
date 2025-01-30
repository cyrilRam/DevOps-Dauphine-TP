

output "mysql_secret_name" {
   value = var.mysql_secret_name  # Utilisation de l'output du module MySQL
}

output "wordpress_url" {
  value = kubernetes_service.gke_wordpress.status[0].load_balancer[0].ingress[0].ip
}
