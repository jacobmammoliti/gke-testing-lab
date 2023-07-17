module "public_dns" {
  count = var.domain == null ? 0 : 1

  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/dns?ref=v24.0.0"

  project_id = module.project.project_id
  type       = "public"
  name       = "public-dns-zone"
  domain     = format("%s.", var.domain)
  recordsets = {
    "A *" = { ttl = 300, records = [module.ingress_address.external_addresses["wildcard"]["address"]] }
  }
}