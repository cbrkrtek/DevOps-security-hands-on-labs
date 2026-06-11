data "yandex_vpc_network" "logistic" {
  name = "logistic"
}

data "yandex_compute_image" "ubuntu_latest" {
  family    = "ubuntu-2204-lts"
  folder_id = "standard-images" 
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "lab02-nat-gateway"
  shared_egress_gateway {} 
}

resource "yandex_vpc_route_table" "private_route_table" {
  name       = "private-route-table"
  network_id = data.yandex_vpc_network.logistic.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private-subnet-b"
  zone           = var.yc_zone
  network_id     = data.yandex_vpc_network.logistic.id
  v4_cidr_blocks = ["10.95.10.0/24"]
  route_table_id = yandex_vpc_route_table.private_route_table.id
}

resource "yandex_compute_instance" "db_vm" {
  name        = "lab02-private-db"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_latest.id
      type     = "network-ssd"
      size     = 30 
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
    nat       = false 
  }

  metadata = {
    ssh-keys = "ubuntu:${file(pathexpand("~/.ssh/id_ed25519.pub"))}"
    user-data = <<EOF
#cloud-config
datasource_list: [ NoCloud, ConfigDrive ]
EOF
  }
}