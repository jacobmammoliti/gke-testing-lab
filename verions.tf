terraform {
  required_version = ">= 1.4.5"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.62.1"
    }
  }
}

provider "random" {}

provider "google" {}