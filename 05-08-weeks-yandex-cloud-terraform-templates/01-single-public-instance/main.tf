data "yandex_vpc_network" "logistic_net"{
  name = "logistic"
}


resource "yandex_vpc_subnet" "public_subnet"{
  name = "public-subnet-a"
  zone = var.yc_zone
  network_id = data.yandex_vpc_network.logistic_net.id
  v4_cidr_blocks = ["10.90.10.0/24"]
}

resource "yandex_compute_instance" "ubuntu_vm" {
  name        = "lab01-public-vm"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd88b6mrujg03uq4v7bq" 
      type     = "network-ssd"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true                                
  }

  metadata = {
    ssh-keys = "ubuntu:${file(pathexpand("~/.ssh/id_ed25519.pub"))}" #here you need to paste your own public ssh key!!!   
    user-data = <<EOF
#cloud-config
datasource_list: [ NoCloud, ConfigDrive ]
EOF
  }
}


