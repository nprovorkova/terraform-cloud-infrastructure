output "control_plane_ip" {
  value = yandex_compute_instance.control-plane-vm.network_interface.0.ip_address
}

output "worker1_ip" {
  value = yandex_compute_instance.worker1-vm.network_interface.0.ip_address
}

output "worker2_ip" {
  value = yandex_compute_instance.worker2-vm.network_interface.0.ip_address
}
