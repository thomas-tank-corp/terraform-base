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

resource "google_container_cluster" "dev" {
  name               = "humanitec-k8-dev"
  location           = "europe-west2-a"
  initial_node_count = 1
}

output "k8_dev_cluster_id" {
    value = google_container_cluster.dev.id
}

output "k8_dev_cluster_master_endpoint" {
    value = google_container_cluster.dev.endpoint
}
