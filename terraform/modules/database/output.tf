output "sql_user" {
  description = "Nom de l'utilisateur SQL"
  value       = google_sql_user.wordpress.name
}