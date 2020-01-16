output "resource_group_id" {
  description = "The resource group ID"
  value       = "${module.resource_group.id}"
}

output "resource_group_name" {
  description = "The resource group name"
  value       = "${module.resource_group.name}"
}

output "resource_group_name_location" {
  description = "The resource group location"
  value       = "${module.resource_group.location}"
}

output "user_managed_identity_name" {
  value = "${azurerm_user_assigned_identity.hadoopIdentity.name}"
}

output "user_managed_identity_principal_id" {
  value = "${azurerm_user_assigned_identity.hadoopIdentity.principal_id}"
}

output "user_managed_identity_client_id" {
  value = "${azurerm_user_assigned_identity.hadoopIdentity.client_id}"
}

output "Virtual_network_id" {
  value = "${module.virtual_network.id}"
}

output "Virtual_network_name" {
  value = "${module.virtual_network.name}"
}

output "Virtual_network_address_space" {
  value = "${module.virtual_network.address_space}"
}

output "data_tier_subnet_id" {
  value = "${module.data_tier_subnet.id}"
}

output "data_tier_subnet_name" {
  value = "${module.data_tier_subnet.name}"
}

output "data_tier_subnet_ipconfiguration" {
  value = "${module.data_tier_subnet.ip_configurations}"
}

output "data_tier_subnet_addressprefix" {
  value = "${module.data_tier_subnet.address_prefix}"
}

output "business_tier_subnet_id" {
  value = "${module.business_tier_subnet.id}"
}

output "business_tier_subnet_name" {
  value = "${module.business_tier_subnet.name}"
}

output "business_tier_subnet_ipconfiguration" {
  value = "${module.business_tier_subnet.ip_configurations}"
}

output "business_tier_subnet_addressprefix" {
  value = "${module.business_tier_subnet.address_prefix}"
}

output "web_tier_subnet_id" {
  value = "${module.web_tier_subnet.id}"
}

output "web_tier_subnet_name" {
  value = "${module.web_tier_subnet.name}"
}

output "web_tier_subnet_ipconfiguration" {
  value = "${module.web_tier_subnet.ip_configurations}"
}

output "web_tier_subnet_addressprefix" {
  value = "${module.web_tier_subnet.address_prefix}"
}

output "data_tier_subnet_network_security_group_id" {
  value       = "${module.data_tier_subnet.network_security_group_id}"
  description = "The subnet's Network Security Group ID."
}

output "business_tier_subnet_network_security_group_id" {
  value       = "${module.business_tier_subnet.network_security_group_id}"
  description = "The subnet's Network Security Group ID."
}

output "web_tier_subnet_network_security_group_id" {
  value       = "${module.web_tier_subnet.network_security_group_id}"
  description = "The subnet's Network Security Group ID."
}

# output "event_hub_namespace_id" {
#   value       = "${module.network_security_group.event_hub_namespace_id}"
#   description = "The default event hub namespace for diagnostic logging."
# }

output "storage_account_id" {
  value       = "${azurerm_storage_account.storage_account1.id}"
  description = "The storage account Resource ID."
}

output "storage_account_name" {
  value       = "${azurerm_storage_account.storage_account1.name}"
  description = "The name of the storage account."
}

output "primary_location" {
  value       = "${azurerm_storage_account.storage_account1.primary_location}"
  description = "The primary location of the storage account."
}

output "primary_blob_endpoint" {
  value       = "${azurerm_storage_account.storage_account1.primary_blob_endpoint}"
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_queue_endpoint" {
  value       = "${azurerm_storage_account.storage_account1.primary_queue_endpoint}"
  description = "The endpoint URL for queue storage in the primary location."
}

output "primary_table_endpoint" {
  value       = "${azurerm_storage_account.storage_account1.primary_table_endpoint}"
  description = "The endpoint URL for table storage in the primary location."
}

output "primary_file_endpoint" {
  value       = "${azurerm_storage_account.storage_account1.primary_file_endpoint}"
  description = "The endpoint URL for file storage in the primary location."
}

output "primary_access_key" {
  value       = "${azurerm_storage_account.storage_account1.primary_access_key}"
  description = "The primary access key for the storage account."
}

output "primary_connection_string" {
  value       = "${azurerm_storage_account.storage_account1.primary_connection_string}"
  description = "The connection string associated with the primary location."
}

output "primary_blob_connection_string" {
  value       = "${azurerm_storage_account.storage_account1.primary_blob_connection_string}"
  description = "The connection string associated with the primary blob location."
}

output "secondary_location" {
  value       = "${azurerm_storage_account.storage_account1.secondary_location}"
  description = "The secondary location of the storage account."
}

output "secondary_access_key" {
  value       = "${azurerm_storage_account.storage_account1.secondary_access_key}"
  description = "The secondary access key for the storage account."
}

output "secondary_connection_string" {
  value       = "${azurerm_storage_account.storage_account1.secondary_connection_string}"
  description = "The connection string associated with the secondary location."
}

output "postgresql_id" {
  value       = "${azurerm_postgresql_server.postgresql.id}"
  description = "The storage account Resource ID."
}

output "postgresql_fqdn" {
  value       = "${azurerm_postgresql_server.postgresql.fqdn}"
  description = "fully qualified domain name"
}

output "identity_id" {
  value = "azurerm_user_assigned_identity.redboxIdentity.id"
}

output "identity_principal_id" {
  value = "azurerm_user_assigned_identity.redboxIdentity.principal_id"
}

output "identity_client_id" {
  value = "azurerm_user_assigned_identity.redboxIdentity.client_id"
}

# output "sql_firewall_id" {
#   value = "${azurerm_sql_firewall_rule.firewallrule.id}"
# }

output "sql_fqdn" {
  value = "${azurerm_sql_server.sqlserver.fully_qualified_domain_name}"
}

output "sql_dns_record" {
  value = "${element(data.dns_a_record_set.sqlserverdns.addrs, 0)}"
}

output "postgesql_dns_record" {
  value = "${element(data.dns_a_record_set.postgresqlserver.addrs, 0)}"
}

//Testing
