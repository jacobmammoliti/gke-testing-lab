resource "random_pet" "cloudsql_name" {
  length = 3
}

module "cloudsql_instance" {
  count = var.provision_addons["cloudsql"] == true ? 1 : 0

  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/cloudsql-instance?ref=v21.0.0"

  project_id       = module.project.project_id
  network          = module.vpc.self_link
  name             = random_pet.cloudsql_name.id
  region           = var.region
  database_version = var.cloud_sql_settings["database_version"]
  tier             = var.cloud_sql_settings["tier"]
}