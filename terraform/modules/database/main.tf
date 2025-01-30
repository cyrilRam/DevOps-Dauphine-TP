resource "google_sql_user" "wordpress" {
  project = var.project_id
   name     = var.db_name
   instance = var.db_instance_name
   password = var.db_password
}

resource "google_sql_database" "wordpress" {
  project = var.project_id
  name     = var.db_name
  instance = var.db_instance_name
}