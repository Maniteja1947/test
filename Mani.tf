data "azurerm_resource_group" "resource_group" {
    name = "${var.resource_group_name}"
}

module "random_name" {
  source = "git::https://github.optum.com/CommercialCloud-EAC/terraform_common//terraform_module/random_name?ref=v1.2.1"
}
# resource "random_string" "uid" {
#     length  = 8
#     upper   = false
#     special = false
#     number  = false
# }
 

module "virtual_network" {
    source              = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//?ref=v2.0.0-beta1"
    name                = "${var.virtual_network_name}"
    # namespace           = "${module.random_name.name}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
    address_space       = ["${var.vm_address_space}"]
    location            = "${var.location}"
}

module "subnet" {
    source                          = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//modules/subnet?ref=v2.0.0-beta1"
    name                            = "${var.data_tier_subnet}"
    # namespace                       = "${module.random_name.name}"
    resource_group_name             = "${data.azurerm_resource_group.resource_group.name}"
    virtual_network_name            = "${module.virtual_network.name}"
    address_prefix                  = "${var.subnet_address_space}"
    network_security_group_name     = "${var.network_security_group_name}"
    network_security_group_location = "${var.location}"
}

resource "azurerm_network_security_rule" "network_security_rule" {
    name                        = "ExampleRule"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    description                 = "An example network security rule."
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "Internet"
    destination_address_prefix  = "${module.subnet.address_prefix}"
    access                      = "Allow"
    priority                    = "200"
    direction                   = "Inbound"
}

resource "azurerm_postgresql_server" "postgresql" {
    name                = "${var.postgresql_server_name}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
    location            = "${var.location}"
    ssl_enforcement     = "Disabled"
    sku {
        name     = "GP_Gen5_4"
        capacity = 4
        tier     = "GeneralPurpose"
        family   = "Gen5"
    }

    storage_profile {
        storage_mb            = 5120
        backup_retention_days = 7
        geo_redundant_backup  = "Disabled"
        auto_grow             = "Enabled"
    }

    administrator_login          = "${var.postgresql_administrator_login}"
    administrator_login_password = "${var.postgresqladmin_password}"
    version                      = "9.5"
    ssl_enforcement              = "${var.ssl_enforcement}"
}

resource "azurerm_postgresql_database" "postgresqldb" {
    name                = "${var.postgresql_db_name}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
    server_name         = "${azurerm_postgresql_server.postgresql.name}"
    charset             = "UTF8"
    collation           = "English_United States.1252"
}

data "dns_a_record_set" "postgresqlserver" {
    host = "${azurerm_postgresql_server.postgresql.fqdn}"
}


resource "azurerm_postgresql_virtual_network_rule" "vnetrules" {
    name                                 = "${module.random_name.name}${module.random_name.name}"
    resource_group_name                  = "${data.azurerm_resource_group.resource_group.name}"
    server_name                          = "${azurerm_postgresql_server.postgresql.name}"
    subnet_id                            = "${module.subnet.id}"
    ignore_missing_vnet_service_endpoint = true
}


resource "azurerm_postgresql_firewall_rule" "firewall_rule" {
    name                = "office"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
    server_name         = "${azurerm_postgresql_server.postgresql.name}"
    start_ip_address    = "0.0.0.0"
    end_ip_address      = "0.0.0.0"
}

resource "azurerm_network_security_rule" "http_out" {
    name                        = "http_out"
    description                 = "Allow outbound http access"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "3000"
    access                      = "Allow"
    direction                   = "Outbound"
    protocol                    = "tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "80"
}

# # Needed for OS updates and pulling some initial packages
resource "azurerm_network_security_rule" "https_out" {
    name                        = "https_out"
    description                 = "Allow outbound https access"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "3001"
    access                      = "Allow"
    direction                   = "Outbound"
    protocol                    = "tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "443"
}

resource "azurerm_network_security_rule" "vnet_outbound" {
    name                        = "vnet_outbound"
    description                 = "Allow VNET Outbound"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "2000"
    access                      = "Allow"
    direction                   = "Outbound"
    protocol                    = "*"
    source_address_prefix       = "VirtualNetwork"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range      = "*"
}

resource "azurerm_network_security_rule" "vnet_inbound" {
    name                        = "vnet_inbound"
    description                 = "Allow VNET Inbound"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "1001"
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "*"
    source_address_prefix       = "VirtualNetwork"
    source_port_range           = "*"
    destination_address_prefix  = "VirtualNetwork"
    destination_port_range      = "*"
}

resource "azurerm_network_security_rule" "http_in" {
    name                        = "http_in"
    description                 = "Allow http in for HTTP->HTTPS redirect (controlled by Apache config) and LetsEncrypt"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "1002"
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "10.0.1.11/32"
    destination_port_range      = "80"
}

resource "azurerm_network_security_rule" "https_in" {
    name                        = "https_in"
    description                 = "Allow https in from Optum networks"
    resource_group_name         = "${data.azurerm_resource_group.resource_group.name}"
    network_security_group_name = "${module.subnet.network_security_group_name}"
    priority                    = "1003"
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "tcp"
    source_address_prefix       = "*"
    source_port_range           = "*"
    destination_address_prefix  = "10.0.1.11/32"
    destination_port_range      = "443"
}
