# Créer le dépôt Artifact Registry
resource "google_artifact_registry_repository" "artifact_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repo_name
  description   = "Dépôt pour stocker les images Docker de l'application"
  format        = "DOCKER"
}
