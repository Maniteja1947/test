resource "azurerm_user_assigned_identity" "hadoopIdentity" {
  resource_group_name = "${module.resource_group.name}"
  location            = "${var.location}"
  name                = "hadoop-datalake"

  tags = {
    system = "hadoopIdentity"
  }
}
