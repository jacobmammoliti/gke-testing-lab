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
}

module "firewall" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall?ref=v21.0.0"
  project_id = module.project.project_id
  network    = module.vpc.name

  ingress_rules = {
    allow-ingress-ssh = {
      description = "Allow SSH traffic on port 22."
      targets     = ["bastion"]
      rules       = [{ protocol = "tcp", ports = [22] }]
    }
    allow-ingress-istio-validation-webhook = {
      description = "Allow Istio Pilot discovery validation webhook."
      targets     = ["tenant"]
      rules       = [{ protocol = "tcp", ports = [443, 10250, 15017] }]
    }
  }
}