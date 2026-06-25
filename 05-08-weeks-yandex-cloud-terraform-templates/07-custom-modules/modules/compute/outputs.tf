output "instance_ip" {
  value       = yandex_compute_instance.this.network_interface[0].ip_address
  description = "Private/Public IP address of the instance"
}