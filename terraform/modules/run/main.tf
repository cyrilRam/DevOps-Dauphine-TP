resource "google_cloud_run_service" "cloud_run_service" {
  name     = var.run_service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}/${var.image_name}:${var.tag}"
        ports {
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }

}

# Autoriser l'accès non authentifié au service Cloud Run
resource "google_cloud_run_service_iam_binding" "public_access" {
  project  = var.project_id
  location = var.region
  service  = google_cloud_run_service.cloud_run_service.name
  role     = "roles/run.invoker"

  members = [
    "allUsers"
  ]
}