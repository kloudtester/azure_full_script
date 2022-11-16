variable "resource_group_name" {
  type = string
}
variable "target_region" {
  type = string
}
variable "virtual_network_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "subnet_name" {

  type = list(string)
}

variable "address_prefixes" {
  type = list(string)
}
variable "linux_virtual_machine_name" {
  type = list(string)
}

variable "network_interface_name" {
  type = list(string)

}
variable "public_ip_name" {
  type = list(string)

}
