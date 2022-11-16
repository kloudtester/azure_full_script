resource "azurerm_linux_virtual_machine" "qtvm" {
  count               = length(var.linux_virtual_machine_name)
  name                = var.linux_virtual_machine_name[count.index]
  resource_group_name = var.resource_group_name
  location            = var.target_region
  size                = "Standard_B1s"
  admin_username      = "satya"
  network_interface_ids = [
    azurerm_network_interface.qtnic[count.index].id
  ]
  depends_on = [
    azurerm_virtual_network.qtvnet

  ]

  admin_ssh_key {
    username   = "satya"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
resource "null_resource" "qtnull" {
  triggers = {
    triggers = "5"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update ",
      "sudo apt install apache2  -y",
      "sudo apt update"
    ]
    connection {
      type        = "ssh"
      user        = "satya"
      private_key = file("C:/Users/pamid/.ssh/id_rsa")
      host        = azurerm_public_ip.qtip[0].ip_address
    }
  }
}
