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
| <a name="module_bastion-vm"></a> [bastion-vm](#module\_bastion-vm) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/compute-vm | v21.0.0 |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall | v21.0.0 |
| <a name="module_project"></a> [project](#module\_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project | v21.0.0 |
| <a name="module_tenant-cluster"></a> [tenant-cluster](#module\_tenant-cluster) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster | v21.0.0 |
| <a name="module_tenant-cluster-hub"></a> [tenant-cluster-hub](#module\_tenant-cluster-hub) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-hub | v21.0.0 |
| <a name="module_tenant-cluster-nodepool-1"></a> [tenant-cluster-nodepool-1](#module\_tenant-cluster-nodepool-1) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool | v20.0.0 |
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
| [random_pet.gke_cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.project_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.router_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | (required) Billing account to attach to the project. | `string` | n/a | yes |
| <a name="input_enabled_services"></a> [enabled\_services](#input\_enabled\_services) | (optional) List of service APIs to enable. | `list(string)` | <pre>[<br>  "container.googleapis.com",<br>  "stackdriver.googleapis.com",<br>  "gkehub.googleapis.com",<br>  "gkeconnect.googleapis.com",<br>  "anthosconfigmanagement.googleapis.com",<br>  "multiclusteringress.googleapis.com",<br>  "multiclusterservicediscovery.googleapis.com",<br>  "mesh.googleapis.com"<br>]</pre> | no |
| <a name="input_gke_disk_size_gb"></a> [gke\_disk\_size\_gb](#input\_gke\_disk\_size\_gb) | (optional) Size of the disk to attach to each node in each GKE node pool. | `number` | `50` | no |
| <a name="input_gke_enable_hub"></a> [gke\_enable\_hub](#input\_gke\_enable\_hub) | (optional) Register GKE cluster(s) to GKE Hub. | `bool` | `true` | no |
| <a name="input_gke_node_pool_count"></a> [gke\_node\_pool\_count](#input\_gke\_node\_pool\_count) | (optional) Number of nodes to create in each GKE node pool. | `number` | `3` | no |
| <a name="input_gke_node_pool_machine_type"></a> [gke\_node\_pool\_machine\_type](#input\_gke\_node\_pool\_machine\_type) | (optional) Machine type to use for each node in each GKE node pool. | `string` | `"e2-medium"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) Map of labels to assign to infrastructure deployed. | `map(string)` | <pre>{<br>  "environment": "tenant"<br>}</pre> | no |
| <a name="input_parent"></a> [parent](#input\_parent) | (required) Parent folder or oranization to place the project in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (optional) Default GCP region to deploy to. | `string` | `"us-central1"` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | (optional) Name of the VPC network to use. | `string` | `"default"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | (optional) Name of the VPC subnetwork to use. | `string` | `"default"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (optional) Default GCP zone to deploy to. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_connect_string"></a> [bastion\_connect\_string](#output\_bastion\_connect\_string) | Bastion host connection string. |
| <a name="output_gke_connect_string"></a> [gke\_connect\_string](#output\_gke\_connect\_string) | GKE connection string. |