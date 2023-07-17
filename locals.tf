locals {
  subnet_name = format("%s/%s", var.region, var.vpc_subnet_name)
  bastion_iam = [
    "roles/container.clusterViewer",
    "roles/container.admin",
    "roles/gkehub.admin"
  ]
}