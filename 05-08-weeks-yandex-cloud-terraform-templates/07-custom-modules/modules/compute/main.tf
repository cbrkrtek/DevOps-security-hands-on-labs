data "yandex_compute_image" "ubuntu"{
    family = "ubuntu-2204-lts"
}
resource "yandex_compute_instance" "this"{
    name = var.instance_name
    platform_id = "standard-v3"
    zone = "ru-central1-a"

    resources{
        cores = 2
        memory = 2
    }

    boot_disk {
        initialize_params{
            image_id = data.yandex_compute_image.ubuntu.id
        }
    }

    network_interface { 
        subnet_id = var.subnet_id
        nat = true
    }
    metadata {
        ssh-keys = "ubuntu:${var.ssh_public_key}"
    }
}