resource "google_service_account" "gke_service_account" {
  project      = module.project.project_id
  account_id   = "gke-tenant"
  display_name = "GKE Tenant Service Account"
}

resource "google_project_iam_member" "project_gke" {
  for_each = toset(local.bastion_iam)

  project = module.project.project_id
  role    = each.key
  member  = format("serviceAccount:%s", google_service_account.gke_service_account.email)
}

resource "random_pet" "gke_cluster_name" {
  length = 2
}

module "tenant_cluster" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-standard?ref=master"

  project_id = module.project.project_id
  name       = format("tenant-%s", resource.random_pet.gke_cluster_name.id)
  location   = var.zone
  vpc_config = {
    network    = module.vpc.name
    subnetwork = module.vpc.subnets[local.subnet_name].name
    secondary_range_names = {
      pods     = "pods"
      services = "services"
    }
    master_authorized_ranges = {
      internal-vms = "10.0.0.0/8"
    }
    master_ipv4_cidr_block = var.gke_settings["master_ip_cidr"]
  }

  min_master_version = "1.25.9-gke.400"

  # backup_configs = {
  #   enable_backup_agent = true
  # }

  enable_addons = {
    config_connector               = true
    gce_persistent_disk_csi_driver = true
  }

  enable_features = {
    shielded_nodes    = true
    dataplane_v2      = true
    autopilot         = false
    workload_identity = true
  }

  release_channel = "RAPID"

  private_cluster_config = {
    enable_private_endpoint = true
    master_global_access    = false
  }

  labels = var.labels
  tags   = ["tenant"]
}

module "tenant_cluster_nodepool_1" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool?ref=master"

  project_id   = module.project.project_id
  cluster_name = module.tenant_cluster.name
  location     = var.zone
  name         = format("%s-nodepool-1", module.tenant_cluster.name)

  gke_version = "1.25.9-gke.400"

  node_count = {
    initial = var.gke_settings["count"]
  }
  node_config = {
    disk_size_gb                  = var.gke_settings["disk_size_gb"]
    machine_type                  = var.gke_settings["machine_type"]
    workload_metadata_config_mode = "GKE_METADATA"
    image_type                    = "COS_CONTAINERD"
    shielded_instance_config = {
      enable_secure_boot = true
    }
    spot = var.gke_settings["spot"]
  }
  nodepool_config = {
    management = {
      auto_repair  = true
      auto_upgrade = true
    }
  }
  service_account = {
    create = false
    email  = google_service_account.gke_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  tags = ["tenant"]
}