resource "azurerm_virtual_network" "qtvnet" {
  name                = var.virtual_network_name
  location            = var.target_region
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.qtrg
  ]
}
resource "azurerm_subnet" "qtpub" {
  count                = length(var.subnet_name)
  name                 = var.subnet_name[count.index]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.qtvnet.name
  address_prefixes     = [var.address_prefixes[count.index]]
  depends_on = [
    azurerm_virtual_network.qtvnet

  ]
}

resource "azurerm_network_interface" "qtnic" {
  count               = length(var.network_interface_name)
  name                = var.network_interface_name[count.index]
  location            = var.target_region
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.qtrg,
    azurerm_public_ip.qtip
  ]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.qtpub[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.qtip[count.index].id
  }
}

resource "azurerm_public_ip" "qtip" {
  count               = length(var.public_ip_name)
  name                = var.public_ip_name[count.index]
  resource_group_name = var.resource_group_name
  location            = var.target_region
  allocation_method   = "Static"
  depends_on = [

    azurerm_resource_group.qtrg
  ]
}