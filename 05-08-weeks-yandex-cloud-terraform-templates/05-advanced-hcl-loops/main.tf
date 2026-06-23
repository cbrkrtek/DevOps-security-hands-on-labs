data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "web_nodes" {
  count = 3 

  name        = "web-node-${count.index + 1}" 
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.loop_subnet.id
    nat                = false 
    security_group_ids = [yandex_vpc_security_group.dynamic_sg.id] 
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}
output "web_node_private_ips" {
  value       = [for instance in yandex_compute_instance.web_nodes : instance.network_interface[0].ip_address]
  description = "List of private IP addresses allocated for web nodes"
}