variable "billing_account" {
  type        = string
  description = "(required) Billing account to attach to the project."
}

variable "cloud_sql_settings" {
  type = object({
    database_version = string
    tier             = string
  })
  description = "(optional) Map of CloudSQL settings."
  default = {
    database_version = "POSTGRES_13"
    tier             = "db-g1-small"
  }
}

variable "domain" {
  type        = string
  description = "(optional) Domain to use for DNS zone."
  default     = null
}

variable "enabled_services" {
  type        = list(string)
  description = "(optional) List of service APIs to enable."
  default = [
    "container.googleapis.com",
    "stackdriver.googleapis.com",
    "servicenetworking.googleapis.com",
    "gkehub.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkebackup.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "mesh.googleapis.com",
    "redis.googleapis.com",
    "anthos.googleapis.com",
  ]
}

variable "gke_enable_hub" {
  type        = bool
  description = "(optional) Register GKE cluster(s) to GKE Hub."
  default     = true
}

variable "gke_settings" {
  type = object({
    count           = number
    disk_size_gb    = number
    machine_type    = string
    master_ip_cidr  = string
    spot            = bool
    preemptible     = bool
    private         = bool
    version         = string
    release_channel = string
  })
  description = "(optional) Map of node pool settings."
  default = {
    count           = 3                 # Number of nodes
    disk_size_gb    = 10                # Size of disk to attach to each node
    machine_type    = "n2-standard-4"   # Instance type to use for each node
    master_ip_cidr  = "192.168.0.0/28"  # CIDR range for GKE master nodes
    spot            = true              # Lower cost VMs built for fault-tolerant workloads
    preemptible     = true              # Mark the node as premmptible
    private         = true              # Whether nodes have internal IP addresses only
    version         = "1.27.2-gke.2100" # GKE version to use for master and worker nodes
    release_channel = "RAPID"           # GKE release channel to subscribe to
  }
}

variable "labels" {
  type        = map(string)
  description = "(optional) Map of labels to assign to infrastructure deployed."
  default = {
    "environment" = "tenant"
  }
}

variable "memorystore_settings" {
  type = object({
    tier    = string
    size_gb = number
    version = string
  })
  description = "(optional) Map of Memorystore settings."
  default = {
    tier    = "STANDARD_HA"
    size_gb = 1
    version = "REDIS_4_0"
  }
}

variable "parent" {
  type        = string
  description = "(required) Parent folder or oranization to place the project in."
}

variable "provision_addons" {
  type        = map(bool)
  description = "(optional) Map of add-on services to provision."
  default = {
    "bastion"     = false
    "cloudsql"    = false
    "memorystore" = false
  }
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
