terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Crear una VM con Oracle
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
    # Simulación de instalación (en práctica se usaría un instalador real)
    echo "Oracle instalado correctamente" > /tmp/oracle_install.log
  EOT

  tags = ["oracle-db"]
}
