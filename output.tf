output "bastion_connect_string" {
  description = "Bastion host connection string."
  value       = var.provision_addons["bastion"] == true ? format("gcloud compute ssh %s --zone %s --project %s", element(split("/", module.bastion_vm[0].instance.id), 5), var.zone, module.project.project_id) : null
}

output "gke_connect_string" {
  description = "GKE connection string."
  value       = format("gcloud container clusters get-credentials tenant-%s --zone %s --project %s", resource.random_pet.gke_cluster_name.id, var.zone, module.project.project_id)
}
