resource "yandex_vpc_network" "loop_network" {
  name = "loop-test-network"
}

resource "yandex_vpc_subnet" "loop_subnet" {
  name           = "loop-subnet-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.150.1.0/24"]
  network_id     = yandex_vpc_network.loop_network.id
}

variable "security_group_rules" {
  type = map(object({
    protocol       = string
    port           = number
    v4_cidr_blocks = list(string)
    description    = string
  }))
  default = {
    "http" = {
      protocol       = "TCP"
      port           = 80
      v4_cidr_blocks = ["0.0.0.0/0"]
      description    = "Allow public HTTP web traffic"
    },
    "https" = {
      protocol       = "TCP"
      port           = 443
      v4_cidr_blocks = ["0.0.0.0/0"]
      description    = "Allow public HTTPS secure traffic"
    },
    "ssh" = {
      protocol       = "TCP"
      port           = 22
      v4_cidr_blocks = ["192.168.1.0/24"] 
      description    = "Allow SSH management from corporate VPN only"
    },
    "prometheus" = {
      protocol       = "TCP"
      port           = 9100
      v4_cidr_blocks = ["10.150.1.0/24"] 
      description    = "Allow internal metrics scraping by Node Exporter"
    }
  }
}

resource "yandex_vpc_security_group" "dynamic_sg" {
  name        = "dynamic-security-group"
  description = "Automated security group generated via HCL loops"
  network_id  = yandex_vpc_network.loop_network.id

  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
      port           = ingress.value.port
    }
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}