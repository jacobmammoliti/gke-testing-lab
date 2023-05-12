module "vpc" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v21.0.0"

  project_id = module.project.project_id
  name       = var.vpc_network_name
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = var.vpc_subnet_name
      region        = var.region
      secondary_ip_ranges = {
        pods     = "10.128.0.0/14"
        services = "172.30.0.0/16"
      }
    }
  ]
  psa_config = {
    ranges = { psa-range = "10.1.0.0/20" } # 10.1.0.0 - 10.1.15.254
    routes = null
  }
}

module "firewall" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall?ref=v21.0.0"

  project_id = module.project.project_id
  network    = module.vpc.name

  ingress_rules = {
    allow-ingress-ssh = {
      description = "Allow SSH traffic on port 22."
      targets     = ["bastion"]
      rules       = [{ protocol = "tcp", ports = [22] }]
    }
    allow-ingress-nginx-ingress-admission-webhook = {
      description   = "Allow NGINX Ingress Controller webhook."
      targets       = ["tenant"]
      source_ranges = [var.gke_settings["master_ip_cidr"]]
      rules         = [{ protocol = "tcp", ports = [8443] }]
    }
  }
}