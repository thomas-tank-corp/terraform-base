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

resource "random_id" "bucket" {
  byte_length = 8
}

resource "google_storage_bucket" "dev" {
  name          = random_id.bucket.hex
  location      = "EU"
  force_destroy = true
}

output "bucket_url" {
    value = google_storage_bucket.dev.url
}
