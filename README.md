# GKE Testing Lab
Single repository to build a testing environment in Google Cloud Platform (GCP) with Google Kubernetes Engine (GKE) and Anthos.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.62.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.73.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_vm"></a> [bastion\_vm](#module\_bastion\_vm) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm | v24.0.0 |
| <a name="module_cloudsql_instance"></a> [cloudsql\_instance](#module\_cloudsql\_instance) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/cloudsql-instance | v24.0.0 |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall | v24.0.0 |
| <a name="module_ingress_address"></a> [ingress\_address](#module\_ingress\_address) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-address | v24.0.0 |
| <a name="module_project"></a> [project](#module\_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project | v24.0.0 |
| <a name="module_public_dns"></a> [public\_dns](#module\_public\_dns) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/dns | v24.0.0 |
| <a name="module_tenant_cluster"></a> [tenant\_cluster](#module\_tenant\_cluster) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-standard | v24.0.0 |
| <a name="module_tenant_cluster_hub"></a> [tenant\_cluster\_hub](#module\_tenant\_cluster\_hub) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-hub | v24.0.0 |
| <a name="module_tenant_cluster_nodepool_1"></a> [tenant\_cluster\_nodepool\_1](#module\_tenant\_cluster\_nodepool\_1) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool | v24.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc | v24.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_project_iam_audit_config.project_audit](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.project_gke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_redis_instance.tenant_cache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |
| [google_service_account.bastion_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.gke_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_pet.cloudsql_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.gke_cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.memorystore_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.project_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.router_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | (required) Billing account to attach to the project. | `string` | n/a | yes |
| <a name="input_cloud_sql_settings"></a> [cloud\_sql\_settings](#input\_cloud\_sql\_settings) | (optional) Map of CloudSQL settings. | ```object({ database_version = string tier = string })``` | ```{ "database_version": "POSTGRES_13", "tier": "db-g1-small" }``` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | (optional) Domain to use for DNS zone. | `string` | `null` | no |
| <a name="input_enabled_services"></a> [enabled\_services](#input\_enabled\_services) | (optional) List of service APIs to enable. | `list(string)` | ```[ "container.googleapis.com", "stackdriver.googleapis.com", "servicenetworking.googleapis.com", "gkehub.googleapis.com", "gkeconnect.googleapis.com", "gkebackup.googleapis.com", "anthosconfigmanagement.googleapis.com", "multiclusteringress.googleapis.com", "multiclusterservicediscovery.googleapis.com", "mesh.googleapis.com", "redis.googleapis.com", "anthos.googleapis.com" ]``` | no |
| <a name="input_gke_enable_hub"></a> [gke\_enable\_hub](#input\_gke\_enable\_hub) | (optional) Register GKE cluster(s) to GKE Hub. | `bool` | `true` | no |
| <a name="input_gke_settings"></a> [gke\_settings](#input\_gke\_settings) | (optional) Map of node pool settings. | ```object({ count = number disk_size_gb = number machine_type = string master_ip_cidr = string spot = bool preemptible = bool private = bool version = string release_channel = string })``` | ```{ "count": 3, "disk_size_gb": 10, "machine_type": "n2-standard-4", "master_ip_cidr": "192.168.0.0/28", "preemptible": true, "private": true, "release_channel": "RAPID", "spot": true, "version": "1.27.2-gke.2100" }``` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) Map of labels to assign to infrastructure deployed. | `map(string)` | ```{ "environment": "tenant" }``` | no |
| <a name="input_memorystore_settings"></a> [memorystore\_settings](#input\_memorystore\_settings) | (optional) Map of Memorystore settings. | ```object({ tier = string size_gb = number version = string })``` | ```{ "size_gb": 1, "tier": "STANDARD_HA", "version": "REDIS_4_0" }``` | no |
| <a name="input_parent"></a> [parent](#input\_parent) | (required) Parent folder or oranization to place the project in. | `string` | n/a | yes |
| <a name="input_provision_addons"></a> [provision\_addons](#input\_provision\_addons) | (optional) Map of add-on services to provision. | `map(bool)` | ```{ "bastion": false, "cloudsql": false, "memorystore": false }``` | no |
| <a name="input_region"></a> [region](#input\_region) | (optional) Default GCP region to deploy to. | `string` | `"us-central1"` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | (optional) Name of the VPC network to use. | `string` | `"default"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | (optional) Name of the VPC subnetwork to use. | `string` | `"default"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (optional) Default GCP zone to deploy to. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_connect_string"></a> [bastion\_connect\_string](#output\_bastion\_connect\_string) | Bastion host connection string. |
| <a name="output_gke_connect_string"></a> [gke\_connect\_string](#output\_gke\_connect\_string) | GKE connection string. |