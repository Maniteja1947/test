resource "azurerm_postgresql_server" "postgresql" {
  name                = "${var.postgresql_server_name}"
  resource_group_name = "${module.resource_group.name}"
  location            = "${var.location}"

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
  resource_group_name = "${module.resource_group.name}"
  server_name         = "${azurerm_postgresql_server.postgresql.name}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

data "dns_a_record_set" "postgresqlserver" {
  host = "${azurerm_postgresql_server.postgresql.fqdn}"
}
