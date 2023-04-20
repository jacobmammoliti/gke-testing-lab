variable "billing_account" {
  type        = string
  description = "(required) Billing account to attach to the project."
}

variable "enabled_services" {
  type        = list(string)
  description = "(optional) List of service APIs to enable."
  default = [
    "container.googleapis.com",
    "stackdriver.googleapis.com",
    "gkehub.googleapis.com",
    "gkeconnect.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "mesh.googleapis.com",
  ]
}

variable "gke_disk_size_gb" {
  type        = number
  description = "(optional) Size of the disk to attach to each node in each GKE node pool."
  default     = 50
}

variable "gke_enable_hub" {
  type        = bool
  description = "(optional) Register GKE cluster(s) to GKE Hub."
  default     = true
}

variable "gke_node_pool_count" {
  type        = number
  description = "(optional) Number of nodes to create in each GKE node pool."
  default     = 3
}

variable "gke_node_pool_machine_type" {
  type        = string
  description = "(optional) Machine type to use for each node in each GKE node pool."
  default     = "e2-medium"
}

variable "labels" {
  type        = map(string)
  description = "(optional) Map of labels to assign to infrastructure deployed."
  default = {
    "environment" = "tenant"
  }
}

variable "parent" {
  type        = string
  description = "(required) Parent folder or oranization to place the project in."
}

variable "region" {
  type        = string
  description = "(optional) Default GCP region to deploy to."
  default     = "us-central1"
}

variable "vpc_network_name" {
  type        = string
  description = "(optional) Name of the VPC network to use."
  default     = "default"
}

variable "vpc_subnet_name" {
  type        = string
  description = "(optional) Name of the VPC subnetwork to use."
  default     = "default"
}

variable "zone" {
  type        = string
  description = "(optional) Default GCP zone to deploy to."
  default     = "us-central1-a"
}
