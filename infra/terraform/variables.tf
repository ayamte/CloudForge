variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "location" {
  type        = string
  description = "location of the Resource Group"
}

variable "container_registry_name" {
  type        = string
  description = "Name of the container registry"
}

variable "aks_location" {
  type        = string
  description = "location of the node pool"
}