output "mysql_service_name" {
  value = kubernetes_service.mysql.metadata[0].name
}

output "mysql_secret_name" {
  value = kubernetes_secret.mysql_secret.metadata[0].name
}
