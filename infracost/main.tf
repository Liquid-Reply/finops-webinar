/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  cluster_type = "simple-regional"
}

provider "google" {
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                      = "terraform-google-modules/kubernetes-engine/google"
  project_id                  = var.project_id
  name                        = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  regional                    = true
  region                      = var.region
  network                     = var.network
  subnetwork                  = var.subnetwork
  ip_range_pods               = var.ip_range_pods
  ip_range_services           = var.ip_range_services
  create_service_account      = true
  enable_binary_authorization = var.enable_binary_authorization
  skip_provisioners           = var.skip_provisioners
  cluster_resource_labels     = var.resource_labels
    node_pools = [
    {
      name            = "pool-01"
      min_count       = 1
      max_count       = 2
      auto_upgrade    = true
    },
    {
      name            = "pool-02"
      min_count       = 0
      max_count       = 0
      auto_upgrade    = true
    }
  ]

  node_pools_labels = {
    all = {
      all-pools-example = true
    }
    pool-01 = {
      pool-01-example = true
      owner = "fstoeber"
    }
  }

  node_pools_tags = {
    all = [
      "all-node-example",
    ]
    pool-01 = [
      "pool-01-example",
    ]
  }

}


resource "google_service_account" "default" {
  account_id    = "instance"
  display_name  = "Instance Service Account"
  project       = var.project_id
}

resource "google_compute_instance" "instance_without-owner-label" {
  project      = var.project_id
  name         = "test-without-owner-label"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance_with-owner-label" {
  project      = var.project_id
  name         = "test-with-owner-label"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  labels       = {
    owner = "fstoeber"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
