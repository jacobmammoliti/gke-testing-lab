resource "random_pet" "router_name" {
  length = 2
}

resource "google_compute_router" "router" {
  name    = random_pet.router_name.id
  region  = var.region
  network = module.vpc.name
  project = module.project.project_id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = format("%s-nat", google_compute_router.router.name)
  router                             = google_compute_router.router.name
  region                             = var.region
  project                            = module.project.project_id
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}