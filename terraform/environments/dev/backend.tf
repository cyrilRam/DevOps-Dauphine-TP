terraform {
  backend "gcs" {
    bucket = "tp-note-449407-tfstate"
    prefix = "env/dev"
  }
}
