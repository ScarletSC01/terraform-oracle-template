variable "credentials_file" {
  description = "Ruta del archivo de credenciales JSON de GCP"
  type        = string
}

variable "project_id" {
  description = "ID del proyecto en GCP"
  type        = string
}

variable "region" {
  description = "Región donde se desplegará la VM"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona de despliegue"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Nombre de la VM de Oracle"
  type        = string
  default     = "oracle-db-instance"
}

variable "machine_type" {
  description = "Tipo de máquina"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Imagen base de la VM (Oracle Linux)"
  type        = string
  default     = "projects/oracle-cloud-public/global/images/oracle-linux-8"
}

variable "credentials_content" {
  type        = string
  description = "Contenido JSON de las credenciales GCP"
}

