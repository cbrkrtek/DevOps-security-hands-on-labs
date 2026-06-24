resource "yandex_vpc_network" "tpl_network" {
  name = "template-test-network"
}

resource "yandex_vpc_subnet" "tpl_subnet" {
  name           = "template-subnet-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.160.1.0/24"]
  network_id     = yandex_vpc_network.tpl_network.id
}