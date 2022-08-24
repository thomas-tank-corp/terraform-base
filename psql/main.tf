terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.33.0"
    }
  }
}

provider "google" {
  project = var.GCP_PROJECT_ID
}

variable "GCP_PROJECT_ID" {}

resource "google_sql_database_instance" "dev" {
  name             = "humanitec-psql-dev"
  database_version = "POSTGRES_14"
  region           = "europe-west2"

  settings {
    tier = "db-f1-micro"
  }
}


resource "random_id" "db_pass" {
  byte_length = 16
}

resource "google_sql_user" "users" {
  name     = "humanitec_user"
  instance = google_sql_database_instance.dev.name
  password = random_id.db_pass.hex
}


output "psql_dev_connection_name" {
    value = google_sql_database_instance.dev.connection_name
}

output "psql_dev_password" {
    value = random_id.db_pass.hex
}
