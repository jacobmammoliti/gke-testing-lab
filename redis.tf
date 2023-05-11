resource "random_pet" "memorystore_name" {
  length = 3
}

resource "google_redis_instance" "tenant_cache" {
  count = var.provision_addons["memorystore"] == true ? 1 : 0

  project            = module.project.project_id
  region             = var.region
  name               = random_pet.memorystore_name.id
  tier               = var.memorystore_settings["tier"]
  memory_size_gb     = var.memorystore_settings["size_gb"]
  redis_version      = var.memorystore_settings["version"]
  authorized_network = module.vpc.self_link
  connect_mode       = "PRIVATE_SERVICE_ACCESS"
}