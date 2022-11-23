terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.38.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.38.0"
    }
  }

  cloud {
    organization = "nullopsco"

    workspaces {
      name = "puppet-docker-compose"
    }
  }
}

resource "random_id" "id" {
  byte_length = 3

}
