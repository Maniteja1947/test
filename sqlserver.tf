resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.sqlserver_name}"
  resource_group_name          = "${module.resource_group.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_sql_database" "sqlserver_db" {
  name                = "${var.sqldatabase}"
  resource_group_name = "${module.resource_group.name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.sqlserver.name}"
  create_mode         = "${var.sql_createmode}"
  edition             = "${var.sql_tier}"
  collation           = "${var.collation}"
  max_size_bytes      = "${var.sql_maxSizeBytes}"
  read_scale          = "${var.sql_readScaleOut}"

  tags = {
    environment = "Dev"
  }
}

data "dns_a_record_set" "sqlserverdns" {
  host = "${azurerm_sql_server.sqlserver.fully_qualified_domain_name}"
}
