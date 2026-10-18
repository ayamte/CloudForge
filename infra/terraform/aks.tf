resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cloudforge-dev"
  location            = var.aks_location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cloudforge-dev"
  sku_tier            = "Free"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D4s_v4"

    upgrade_settings {
      max_surge                     = "10%"
      drain_timeout_in_minutes      = 0
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
  }
}