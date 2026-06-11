output "db_internal_ip" {
  value       = yandex_compute_instance.db_vm.network_interface[0].ip_address
  description = "Internal IP address of the private DB instance"
}