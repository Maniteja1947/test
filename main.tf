resource "random_string" "uid" {
  length  = 8
  upper   = false
  special = false
  number  = false
}

module "random_name" {
  source = "git::https://github.optum.com/CommercialCloud-EAC/terraform_common//terraform_module/random_name?ref=v1.2.1"
}

data "azurerm_resource_group" "resource_group" {
  name = "${var.resource_group_name}"
}
