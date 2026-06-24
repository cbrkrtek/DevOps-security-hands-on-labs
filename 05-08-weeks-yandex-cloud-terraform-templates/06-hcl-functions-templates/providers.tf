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

variable "folder_id" { type = string }
variable "ssh_public_key" { type = string }

variable "env" {
  type    = string
  default = "prod" 
}

variable "app_configs" {
  type = map(map(string))
  default = {
    dev  = { port = "8080", user = "developer" }
    prod = { port = "80",   user = "sysadmin" }
  }
}