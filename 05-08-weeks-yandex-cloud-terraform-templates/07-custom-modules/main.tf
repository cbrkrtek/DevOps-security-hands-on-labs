module "production_vpc" {
  source       = "./modules/vpc"
  network_name = "modular-prod-network"
  subnet_name  = "modular-prod-subnet-a"
  zone         = "ru-central1-a"
  cidr_block   = "10.170.1.0/24"
}

module "web_server" {
  source         = "./modules/compute"
  instance_name  = "modular-nginx-web"
  subnet_id      = module.production_vpc.subnet_id
  ssh_public_key = var.ssh_public_key
}

output "deployed_vm_ip" {
  value       = module.web_server.instance_ip
  description = "IP address of the deployed modular VM"
}