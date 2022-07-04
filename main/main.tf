terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "netology-graduation-project-bucket"
    region     = "ru-central1"
    key        = "data"
    access_key = "***"
    secret_key = "***"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  cloud_id  = "b1g3s8lnqjnl4svbgr1b"
  folder_id = "b1gg1276n3b2qlltke1k"
  zone      = local.zones.b.zone_name
}

data "terraform_remote_state" "netology-graduation-project-state" {
  backend = "s3"
  workspace = terraform.workspace
  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = local.bucket_name
    key        = format("%s-terraform.tfstate", terraform.workspace)
    access_key = "***"
    secret_key = "***"

    region                      = local.region
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

locals {
  region = "ru-central1"
  zones = {
    a = {
      zone_name      = "ru-central1-a"
      public_subnet  = ["192.168.10.0/24"]
      private_subnet = ["192.168.50.0/24"]
    }
    b = {
      zone_name      = "ru-central1-b"
      public_subnet  = ["192.168.11.0/24"]
      private_subnet = ["192.168.51.0/24"]
    }
  }
  bucket_name = "netology-graduation-project-bucket"
}
