variable "project_id" {
  description = "ID du projet Google Cloud"
}

variable "db_instance_name" {
  description = "Nom de l'instance SQL"
  type        = string
}

variable "db_name" {
  description = "Nom de l'utilisateur de la base de données"
  type        = string
}

variable "db_password" {
  description = "Mot de passe de l'utilisateur de la base de données"
  type        = string
  sensitive   = true
}