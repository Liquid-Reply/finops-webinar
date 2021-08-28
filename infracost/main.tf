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
  version = "~> 3.42.0"
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
      min_count       = 1
      max_count       = 2
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



# module "gke" {
#   source                     = "terraform-google-modules/kubernetes-engine/google"
#   project_id                 = var.project_id
#   name                       = "gke-test-1"
#   region                     = "us-central1"
#   zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
#   network                    = "default"
#   create_service_account      = true
#   subnetwork                 = "default"
#   ip_range_pods              = ""
#   ip_range_services          = ""
#   http_load_balancing        = false
#   horizontal_pod_autoscaling = true
#   network_policy             = false

#   node_pools = [
#     {
#       name                      = "default-node-pool"
#       machine_type              = "e2-medium"
#       node_locations            = "us-central1-b,us-central1-c"
#       min_count                 = 1
#       max_count                 = 100
#       local_ssd_count           = 0
#       disk_size_gb              = 100
#       disk_type                 = "pd-standard"
#       image_type                = "COS"
#       auto_repair               = true
#       auto_upgrade              = true
#       preemptible               = false
#       initial_node_count        = 80
#     },
#   ]

#   node_pools_oauth_scopes = {
#     all = []

#     default-node-pool = [
#       "https://www.googleapis.com/auth/cloud-platform",
#     ]
#   }

#   node_pools_labels = {
#     all = {}

#     default-node-pool = {
#       default-node-pool = true
#       owner = "fstoeber"
#     }
#   }

#   node_pools_metadata = {
#     all = {}

#     default-node-pool = {
#       node-pool-metadata-custom-value = "my-node-pool"
#     }
#   }

#   node_pools_taints = {
#     all = []

#     default-node-pool = [
#       {
#         key    = "default-node-pool"
#         value  = true
#         effect = "PREFER_NO_SCHEDULE"
#       },
#     ]
#   }

#   node_pools_tags = {
#     all = []

#     default-node-pool = [
#       "default-node-pool",
#     ]
#   }
# }