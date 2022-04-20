
resource "azurerm_network_security_group" "nsgspoke01" {
  name                = var.nsgspoke01
  location            = "westeurope"
  resource_group_name = "kafkajmd"
}


resource "azurerm_virtual_network" "vnetspoke01" {
  name                = var.vnetspoke01
  location            = "westeurope"
  resource_group_name = "kafkajmd"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = var.Subnetspoke01
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.nsgspoke01.id
  }

  subnet {
    name           = var.Subnetspoke02
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsgspoke01.id
  }

  subnet {
    name           = var.Subnetspoke03
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.nsgspoke01.id
  }


  tags = {
    environment = "Production"
  }
}