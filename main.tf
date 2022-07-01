terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket = "netology-graduation-project-bucket"
    region = "ru-central1"
    key    = "bucket-key-path"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  cloud_id  = "b1g3s8lnqjnl4svbgr1b"
  folder_id = "b1gg1276n3b2qlltke1k"
  zone      = local.zones.b.zone_name
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.bucket_name
    key    = format( "env:/%s/bucket-key-path", terraform.workspace)
    region = local.region
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
    c = {
      zone_name      = "ru-central1-c"
      public_subnet  = ["192.168.12.0/24"]
      private_subnet = ["192.168.52.0/24"]
    }
  }
  bucket_name = "netology-graduation-project-bucket"
}
