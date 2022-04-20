resource "azurerm_resource_group" "rghub01" {
  name     = var.rghub01
  location = var.location.name
}

resource "azurerm_network_security_group" "rghub01" {
  name                = var.rghub01
  location            = var.location.name
  resource_group_name = azurerm_resource_group.rghub01.name
}

resource "azurerm_virtual_network" "vnethub01" {
  name                = var.vnethub01
  location            = var.location.name
  resource_group_name = azurerm_resource_group.rghub01.name
  address_space       = ["11.0.0.0/16"]
  dns_servers         = ["11.0.0.4", "11.0.0.5"]

  subnet {
    name           = var.Subnethub01
    address_prefix = "11.0.1.0/24"
    security_group = azurerm_network_security_group.rghub01.id
  }

  subnet {
    name           = var.Subnethub02
    address_prefix = "11.0.2.0/24"
    security_group = azurerm_network_security_group.rghub01.id
  }

  tags = {
    environment = "Production"
  }
}

# enable global peering between the two virtual network
resource "azurerm_virtual_network_peering" "peering" {
  count                        = length(var.location)
  name                         = "peering-Vnet01-to-Vnet02"
  resource_group_name          = var.rghub01
  virtual_network_name         = azurerm_virtual_network.vnethub01.name
  remote_virtual_network_id    = azurerm_virtual_network.vnetspoke01.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}