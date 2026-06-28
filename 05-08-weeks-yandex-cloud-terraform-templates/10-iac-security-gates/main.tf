resource "yandex_vpc_security_group" "vulnerable_sg" {
  name        = "vulnerable-security-group"
  network_id  = yandex_vpc_network.env_net.id

  ingress {
    protocol       = "TCP"
    description    = "CRITICAL VULNERABILITY: SSH open to the world!"
    v4_cidr_blocks = ["0.0.0.0/0"] #here's the vulnerability!
    port           = 22
  }
}