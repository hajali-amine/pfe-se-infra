data "azurerm_resource_group" "dev" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "pfe-se"
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
  dns_prefix          = "pfe-se"
  sku_tier            = "Free"

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    vm_size             = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  provisioner "local-exec" {
    command = "echo ${self.kube_config_raw} >> ~/.kube/config"
  }

  tags = {
    Environment = "Development"
  }
}

