# Crear VM Oracle
resource "google_compute_instance" "oracle_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.image
      size  = 50
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Instalando Oracle..."
    sudo apt update -y
    sudo apt install -y wget unzip
    echo "Oracle instalado correctamente" > /tmp/oracle_install.log
  EOT

  tags = ["oracle-db"]
}

# Firewall para permitir acceso al puerto Oracle (1521)
resource "google_compute_firewall" "oracle_firewall" {
  name    = "allow-oracle"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["1521"]
  }

  target_tags   = ["oracle-db"]
  source_ranges = ["0.0.0.0/0"]
}

