locals {
  region = "us-central1"
  repo_name="website-tools"
  project_id="tp-note-449407"
  image_name="image-wordpress"
  tag="latest"
  db_instance="main-instance"
  db_name="wordpress"
  db_password="ilovedevops"
  run_service_name="run-wordpress-dev"
  mysql_root_password="rootpassword"
  mysql_password="wordpresspassword"
  mysql_secret_name="mysql-secret"
}

resource "random_password" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  number  = true
}

module "artifact_registry" {
  source     = "./../../modules/artifactory"
  project_id = local.project_id
  region     = local.region
  repo_name  = local.repo_name
}

module "activate_api"{
  source     = "./../../modules/api"
  project_id = local.project_id
}

module "wordpress"{
  source = "./../../modules/database"
  project_id = local.project_id
  db_instance_name = local.db_instance
  db_name          = local.db_name
  db_password      = local.db_password
}

module "cloud_run_service"{
  source     = "./../../modules/run"
  region = local.region
  project_id = local.project_id
  run_service_name=local.run_service_name
  image_name = local.image_name
  repo_name = local.repo_name
  tag = local.tag
}

module "mysql" {
  source              = "./../../modules/gke_sql"
  mysql_root_password = local.mysql_root_password
  mysql_password      = random_password.db_password.result
}

module "gke_wordpress" {
  source             = "./../../modules/gke_wordpress"
  mysql_service_name = module.mysql.mysql_service_name  # Passe l'output du module MySQL
  mysql_secret_name  = module.mysql.mysql_secret_name   # Passe l'output du module MySQL
}