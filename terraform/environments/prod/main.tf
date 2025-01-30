locals {
  region = "us-central1"
  repo_name="website-tools"
  project_id="test-tp-447615"
  image_name="wordpress-docker"
  tag="latest"
  db_instance="main-instance"
  db_name="wordpress"
  db_password="ilovedevops"
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
