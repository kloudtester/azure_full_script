resource_group_name  = "devrg1"
target_region        = "eastus"
virtual_network_name = "devvent"
subnet_name =  ["devpubilc", "devprivate"]

network_interface_name =[ "devnic","devnic1"]
public_ip_name         = ["devip","devip1"]
linux_virtual_machine_name =  ["devvm", "devvm3"]

address_space    = ["10.0.0.0/16"]
address_prefixes = ["10.0.1.0/24", "10.0.3.0/24"]

