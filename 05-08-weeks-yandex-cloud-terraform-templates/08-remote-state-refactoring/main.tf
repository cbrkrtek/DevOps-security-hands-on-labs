locals {
  env_profile = lookup(var.environment_profiles, terraform.workspace, var.environment_profiles["dev"])
}

resource "yandex_vpc_network" "env_net" {
  name = "network-${terraform.workspace}" 
}

resource "yandex_vpc_subnet" "env_sub" {
  name           = "subnet-${terraform.workspace}-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = [local.env_profile.sub_cidr] 
  network_id     = yandex_vpc_network.env_net.id
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "env_vm" {
  name        = "node-${terraform.workspace}" 
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = local.env_profile.instance_cores  
    memory = local.env_profile.instance_memory 
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = local.env_profile.boot_disk_size  
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.env_sub.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

output "current_environment_details" {
  value = {
    workspace = terraform.workspace
    ip        = yandex_compute_instance.env_vm.network_interface[0].ip_address
    cores     = yandex_compute_instance.env_vm.resources[0].cores
  }
}