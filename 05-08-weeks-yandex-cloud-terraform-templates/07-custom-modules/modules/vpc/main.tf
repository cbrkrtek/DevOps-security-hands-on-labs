resource "yandex_vpc_network" "this"{
    name = var.network_name
}

resource "yandex_vpc_subnet" "this"{
    name = var.subnet_name
    zone = var.zone
    v4_cidr_blocks = var.cidr_block
    network_id = yandex_vpc_network.this.id
}
