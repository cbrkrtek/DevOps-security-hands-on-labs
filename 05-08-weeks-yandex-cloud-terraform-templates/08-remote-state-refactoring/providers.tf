terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.80.0"
    }
  }

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "bucket-name" 
    key      = "labs/environments.tfstate"
    region   = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    
    use_lockfile = true
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "key.json"
  folder_id                = var.folder_id
}