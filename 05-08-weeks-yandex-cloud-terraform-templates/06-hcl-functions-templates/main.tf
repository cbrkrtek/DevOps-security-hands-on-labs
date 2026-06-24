data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

locals {
  current_config = lookup(var.app_configs, var.env, { port = "8000", user = "ubuntu" })
  
  user_data_rendered = templatefile("${path.module}/users.tpl.yaml", {
    username = local.current_config["user"]
    ssh_key  = var.ssh_public_key
    env_name = var.env
    app_port = local.current_config["port"]
  })
}

resource "yandex_compute_instance" "tpl_node" {
  name        = "templated-node-${var.env}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.tpl_subnet.id
    nat       = true
  }

  metadata = {
    user-data = local.user_data_rendered
  }
}

output "rendered_cloud_init_sample" {
  value       = local.user_data_rendered
  description = "Check the final generated YAML-file for OS"
}