output "oracle_instance_name" {
  description = "Nombre de la instancia Oracle creada"
  value       = google_compute_instance.oracle_instance.name
}

output "oracle_instance_ip" {
  description = "Dirección IP externa de la instancia Oracle"
  value       = google_compute_instance.oracle_instance.network_interface[0].access_config[0].nat_ip
}

output "oracle_machine_type" {
  description = "Tipo de máquina asignada a la instancia Oracle"
  value       = google_compute_instance.oracle_instance.machine_type
}

output "oracle_zone" {
  description = "Zona en la que se desplegó la instancia"
  value       = google_compute_instance.oracle_instance.zone
}
