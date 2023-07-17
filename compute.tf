resource "google_service_account" "bastion_service_account" {
  count = var.provision_addons["bastion"] == true ? 1 : 0

  display_name = "Bastion Service Account"
  project      = module.project.project_id
  account_id   = "bastion"
}

resource "google_project_iam_member" "project" {
  for_each = { for role in local.bastion_iam : role => role if var.provision_addons["bastion"] == true }

  project = module.project.project_id
  role    = each.value
  member  = format("serviceAccount:%s", google_service_account.bastion_service_account[0].email)
}

module "bastion_vm" {
  count = var.provision_addons["bastion"] == true ? 1 : 0

  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm?ref=v24.0.0"

  project_id = module.project.project_id
  zone       = var.zone
  name       = "bastion"

  network_interfaces = [{
    network    = module.vpc.name
    subnetwork = module.vpc.subnet_self_links[local.subnet_name]
  }]

  metadata = {
    startup-script = <<-EOF
      #! /bin/bash
      apt-get update
      apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin google-cloud-sdk-nomos kubectl
      curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    EOF
  }
  instance_type          = "e2-medium"
  service_account        = google_service_account.bastion_service_account[0].email
  service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  tags                   = ["bastion"]
}