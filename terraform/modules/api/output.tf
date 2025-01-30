output "enabled_services" {
  value       = [for service in google_project_service.enable_services : service.service]
  description = "Liste des services Google Cloud activés"
}
