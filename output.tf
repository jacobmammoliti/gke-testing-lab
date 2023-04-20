output "bastion_connect_string" {
  description = "Bastion host connection string."
  value       = format("gcloud compute ssh %s --zone %s --project %s", element(split("/", module.bastion-vm.instance.id), 5), var.zone, module.project.project_id)
}

output "gke_connect_string" {
  description = "GKE connection string."
  value       = format("gcloud container clusters get-credentials tenant-%s --zone %s --project %s", resource.random_pet.gke_cluster_name.id, var.zone, module.project.project_id)
}
