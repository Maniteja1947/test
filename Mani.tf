resource "random_string" "uid" {
    length  = 8
    upper   = false
    special = false
    number  = false
}

module "random_name" {
    source = "git::https://github.optum.com/CommercialCloud-EAC/terraform_common//terraform_module/random_name?ref=v1.2.1"
}
resource "azurerm_app_service_plan" "nonprod" {
  name                = "appserviceplan"
  location            = "${var.location}"
  namespace           = "${module.random_name.name}"
  resource_group_name = "${var.resource_group_name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "nonprod" {
  name                = "app-service"
  location            = "${var.resource_group_name}"
  resource_group_name = "${var.resource_group_name}"
 }
