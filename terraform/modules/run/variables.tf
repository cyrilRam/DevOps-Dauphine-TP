# Fichier variables.tf

variable "project_id" {
  description = "ID du projet Google Cloud"
  type        = string
}

variable "region" {
  description = "Région pour le dépôt Artifact Registry"
  type        = string
}

variable "run_service_name" {
  description = "Nom du service Cloud Run"
  type        = string
}

variable "image_name" {
  description = "Nom de l'image Docker"
  type        = string
}

variable "repo_name" {
  description = "Nom du dépôt Artifact Registry"
  type        = string
}

variable "tag" {
  description = "Tag de l'image Docker"
  type        = string
  default     = "latest"
}
