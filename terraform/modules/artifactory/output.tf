output "artifact_repo_url" {
  description = "URL du dépôt Artifact Registry"
  value       = google_artifact_registry_repository.artifact_repo.repository_id
}