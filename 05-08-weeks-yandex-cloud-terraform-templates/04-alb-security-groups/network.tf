resource "yandex_vpc_network" "core_network" {
  name        = "production-network"
  description = "Root network for enterprise infrastructure"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "alb-subnet-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.10.1.0/24"]
  network_id     = yandex_vpc_network.core_network.id
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "alb-subnet-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.10.2.0/24"]
  network_id     = yandex_vpc_network.core_network.id
}

resource "yandex_vpc_security_group" "alb_sg" {
  name        = "alb-security-group"
  network_id  = yandex_vpc_network.core_network.id

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP from anywhere"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow internal healthchecks"
    v4_cidr_blocks = ["10.10.1.0/24", "10.10.2.0/24"]
    port           = 80
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}