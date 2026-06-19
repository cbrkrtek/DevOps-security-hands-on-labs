terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3       = "https://storage.yandexcloud.net"
    }
    
    bucket = "bucket-for-03-s3-backend-locking" 
    region = "ru-central1"
    key    = "terraform.tfstate"      

    use_lockfile = true

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "key.json"
  folder_id = var.folder_id
}

data "yandex_vpc_network" "my-network-test-cli" {
  name = "my-network-test-cli" 
}

resource "yandex_vpc_subnet" "remote_state_subnet" {
  name           = "subnet-03-s3-backend-locking"
  zone           = "ru-central1-a"
  network_id     = data.yandex_vpc_network.my-network-test-cli.id
  v4_cidr_blocks = ["10.95.30.0/24"]
}

variable "folder_id"{
  type = string
  description = "Folder ID"
}