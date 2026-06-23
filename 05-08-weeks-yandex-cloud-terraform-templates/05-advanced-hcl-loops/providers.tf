terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.80.0"
    }
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = "key.json"
  folder_id                = var.folder_id
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key for secure instance management"
}