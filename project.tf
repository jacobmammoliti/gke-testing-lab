resource "random_pet" "project_name" {
  length = 3
}

module "project" {
  source          = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project?ref=v21.0.0"
  billing_account = var.billing_account
  name            = random_pet.project_name.id
  parent          = var.parent
  services        = var.enabled_services
  iam = {
    "roles/gkehub.serviceAgent" = [
      "serviceAccount:${module.project.service_accounts.robots.fleet}"
    ]
  }
}

resource "google_project_iam_audit_config" "project_audit" {
  project = module.project.project_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}