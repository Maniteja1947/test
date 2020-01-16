# Create virtual network
module "virtual_network" {
  source              = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network?ref=v2.0.0-beta2"
  name                = "${var.virtual_network_name}"
  namespace           = "${module.random_name.name}"
  address_space       = ["${var.vm_address_space}"]
  location            = "${var.location}"
  resource_group_name = "${module.resource_group.name}"
}

# module "public_ip" {
#   source                  = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//modules/public_ip/dynamic_with_domain/?ref=v2.0.0-beta2"
#   name                    = "${var.public_ip_name}"
#   namespace               = "${module.random_name.name}"
#   resource_group_name     = "${module.resource_group.name}"
#   location                = "${var.location}"
#   idle_timeout_in_minutes = "4"
#   domain_name_label       = "${module.random_name.name}"
# }

# Create subnet for web tier
module "web_tier_subnet" {
  source                          = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//modules/subnet?ref=v2.0.0-beta2"
  name                            = "${var.web_tier_subnet}"
  namespace                       = "${module.random_name.name}"
  resource_group_name             = "${module.resource_group.name}"
  virtual_network_name            = "${module.virtual_network.name}"
  address_prefix                  = "${var.subnet_address_space}"
  network_security_group_name     = "web_tier_nsg"
  network_security_group_location = "${var.location}"
}

resource "azurerm_network_security_rule" "allow_inbound_https_rule" {
  name                        = "AllowInboundHttps"
  resource_group_name         = "${module.resource_group.name}"
  network_security_group_name = "${module.web_tier_subnet.network_security_group_name}"
  priority                    = "100"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "10.0.1.0/24"
  description                 = "Allow inbound traffic using https."
}

resource "azurerm_network_security_rule" "allow_outbound_to_business_tier_rule" {
  name                        = "AllowOutboundToBusinessTier"
  resource_group_name         = "${module.resource_group.name}"
  network_security_group_name = "${module.web_tier_subnet.network_security_group_name}"
  priority                    = "200"
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "10.0.1.0/24"
  destination_address_prefix  = "10.0.2.0/24"
  description                 = "Allow outbound traffic to business tier."
}

// Setting up Business Tier
module "business_tier_subnet" {
  source                          = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//modules/subnet?ref=v2.0.0-beta2"
  name                            = "${var.business_tier_subnet}"
  namespace                       = "${module.random_name.name}"
  resource_group_name             = "${module.resource_group.name}"
  virtual_network_name            = "${module.virtual_network.name}"
  address_prefix                  = "${var.subnet2_address_space}"
  network_security_group_name     = "business_tier_nsg"
  network_security_group_location = "${var.location}"
}

resource "azurerm_network_security_rule" "allow_inbound_from_web_tier_rule" {
  name                        = "AllowInboundFromWebTier"
  resource_group_name         = "${module.resource_group.name}"
  network_security_group_name = "${module.business_tier_subnet.network_security_group_name}"
  priority                    = "100"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "10.0.1.0/24"
  destination_address_prefix  = "10.0.2.0/24"
  description                 = "Allow inbound traffic from web tier."
}

resource "azurerm_network_security_rule" "allow_outbound_to_data_tier_rule" {
  name                        = "AllowOutboundToDataTier"
  resource_group_name         = "${module.resource_group.name}"
  network_security_group_name = "${module.business_tier_subnet.network_security_group_name}"
  priority                    = "200"
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "10.0.2.0/24"
  destination_address_prefix  = "10.0.3.0/24"
  description                 = "Allow outbound traffic to data tier."
}

// Setting up Data Tier

module "data_tier_subnet" {
  source                          = "git::https://github.optum.com/CommercialCloud-EAC/azure_virtual_network//modules/subnet?ref=v2.0.0-beta2"
  name                            = "${var.data_tier_subnet}"
  namespace                       = "${module.random_name.name}"
  resource_group_name             = "${module.resource_group.name}"
  virtual_network_name            = "${module.virtual_network.name}"
  address_prefix                  = "10.0.3.0/24"
  network_security_group_name     = "data_tier_nsg"
  network_security_group_location = "${var.location}"
  service_endpoints               = ["Microsoft.Storage"]
}

resource "azurerm_network_security_rule" "allow_inbound_from_business_tier_rule" {
  name                        = "AllowInboundFromBusinessTier"
  resource_group_name         = "${module.resource_group.name}"
  network_security_group_name = "${module.data_tier_subnet.network_security_group_name}"
  priority                    = "100"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "10.0.2.0/24"
  destination_address_prefix  = "10.0.3.0/24"
  description                 = "Allow inbound traffic from business tier."
}
