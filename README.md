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
| <a name="provider_google"></a> [google](#provider\_google) | 4.62.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_vm"></a> [bastion\_vm](#module\_bastion\_vm) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm | v21.0.0 |
| <a name="module_cloudsql_instance"></a> [cloudsql\_instance](#module\_cloudsql\_instance) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/cloudsql-instance | v21.0.0 |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall | v21.0.0 |
| <a name="module_project"></a> [project](#module\_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project | v21.0.0 |
| <a name="module_tenant_cluster"></a> [tenant\_cluster](#module\_tenant\_cluster) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-standard | master |
| <a name="module_tenant_cluster_hub"></a> [tenant\_cluster\_hub](#module\_tenant\_cluster\_hub) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-hub | v21.0.0 |
| <a name="module_tenant_cluster_nodepool_1"></a> [tenant\_cluster\_nodepool\_1](#module\_tenant\_cluster\_nodepool\_1) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool | master |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc | v21.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_project_iam_audit_config.project_audit](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.project_gke](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.bastion_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.gke_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_pet.cloudsql_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.gke_cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.project_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.router_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | (required) Billing account to attach to the project. | `string` | n/a | yes |
| <a name="input_cloud_sql_settings"></a> [cloud\_sql\_settings](#input\_cloud\_sql\_settings) | (optional) Map of CloudSQL settings. | `map(string)` | ```{ "database_version": "POSTGRES_13", "tier": "db-g1-small" }``` | no |
| <a name="input_enabled_services"></a> [enabled\_services](#input\_enabled\_services) | (optional) List of service APIs to enable. | `list(string)` | ```[ "container.googleapis.com", "stackdriver.googleapis.com", "servicenetworking.googleapis.com", "gkehub.googleapis.com", "gkeconnect.googleapis.com", "anthosconfigmanagement.googleapis.com", "multiclusteringress.googleapis.com", "multiclusterservicediscovery.googleapis.com", "mesh.googleapis.com" ]``` | no |
| <a name="input_gke_enable_hub"></a> [gke\_enable\_hub](#input\_gke\_enable\_hub) | (optional) Register GKE cluster(s) to GKE Hub. | `bool` | `true` | no |
| <a name="input_gke_node_pool_settings"></a> [gke\_node\_pool\_settings](#input\_gke\_node\_pool\_settings) | (optional) Map of node pool settings. | `map(any)` | ```{ "count": 3, "disk_size_gb": 50, "machine_type": "e2-medium" }``` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) Map of labels to assign to infrastructure deployed. | `map(string)` | ```{ "environment": "tenant" }``` | no |
| <a name="input_parent"></a> [parent](#input\_parent) | (required) Parent folder or oranization to place the project in. | `string` | n/a | yes |
| <a name="input_provision_addons"></a> [provision\_addons](#input\_provision\_addons) | (optional) Map of add-on services to provision. | `map(bool)` | ```{ "bastion": true, "cloudsql": true }``` | no |
| <a name="input_region"></a> [region](#input\_region) | (optional) Default GCP region to deploy to. | `string` | `"us-central1"` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | (optional) Name of the VPC network to use. | `string` | `"default"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | (optional) Name of the VPC subnetwork to use. | `string` | `"default"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (optional) Default GCP zone to deploy to. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_connect_string"></a> [bastion\_connect\_string](#output\_bastion\_connect\_string) | Bastion host connection string. |
| <a name="output_gke_connect_string"></a> [gke\_connect\_string](#output\_gke\_connect\_string) | GKE connection string. |