output "cloud_run_url" {
  description = "URL du service Cloud Run déployé"
  value       = google_cloud_run_service.cloud_run_service.status[0].url
}
