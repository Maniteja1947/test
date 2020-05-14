variable "virtual_network_name" {}

variable "vm_address_space" {}

variable location {}

variable location1 {}

variable "resource_group_name" {}

variable "web_tier_subnet" {}

variable "business_tier_subnet" {}

variable "postgresql_subnet" {}

variable "subnet_address_space" {}

variable "subnet2_address_space" {}

variable "subnet3_address_space" {}

variable "key_vault_name" {}

variable "key_vault_secret_connectionstring" {}

variable "key_vault_postgresql_password" {}

variable "public_ip_name" {}

variable "network_security_group_name" {}

variable "network_interface_name" {}

variable "storage_account_name" {}

variable "key_vault_secret_storagekey1" {}

variable "key_vault_secret_storagekey2" {}

variable "key_vault_secret_storageconnectionstring1" {}

variable "key_vault_secret_storageconnectionstring2" {}

variable "account_kind" {}

variable "account_tier" {}

variable "account_replication_type" {
  type        = "string"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
}

variable "access_tier" {
  type        = "string"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
}

variable "account_encryption_source" {
  type        = "string"
  description = "The Encryption Source for this Storage Account. Possible values are Microsoft.Keyvault and Microsoft.Storage."
}

variable "ip_rules" {
  description = "List of IPs to allow storage account access from."
  type        = "list"
  default     = []
}

# variable "virtual_network_subnet_ids" {
#   description = "A list of subnet ids that are allowed to use the storage account."
#   type        = "list"
#   default     = []
# }

variable "bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  type        = "list"
}

variable "default_action" {
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
  type        = "string"
}

variable "hns_enabled" {
    description = " This can be used with Azure Data Lake Storage Gen 2. This is to access objects in like folders"
    type        = "string"
}

# variable "tags" {
#     type        = "map"
#     description = "Map of tags to apply to storage resources."
#     default     = {}
# }

variable "global_tags" {
    type        = "map"
    description = "Map of tags to apply to all resources that have tags parameters."
    default     = {}
}

variable "image_tag" {}

variable "ui_image_name" {}

variable "api_image_name" {}

variable "app_service_ui" {}

variable "app_service_webdataconn_ui" {}

variable "app_service_plan_name" {}

variable "app_plan_kind" {}

variable "app_service_https" {}

variable "app_plan_sku_tier" {}

variable "app_plan_sku_size" {}

variable "prest_debug" {}

variable "prest_http" {}

variable "prest_port" {}

variable "container_registry" {}

variable "container_registry_sku" {}

variable "container_registry_admin" {}

variable "storage_container" {}

variable "postgresql_server_name" {}

variable "postgresql_administrator_login" {}

variable "postgresqladmin_password" {}

variable "postgresql_sku_name" {}

variable "postgresql_sku_tier" {}

variable "postgresql_sku_family" {}

variable "postgresql_geo_backup" {}

variable "postgresql_auto_grow" {}

variable "postgresql_version" {}

variable "postgresql_database_charset" {}

variable "postgresql_database_collation" {}

variable "postgresql_firewall_rule_name" {}

variable "postgresql_firewall_ip" {}

variable "ssl_enforcement" {}

variable "postgresql_db_name" {}

variable "user_assigned_identity" {}

variable "datafactory_name" {}

variable "pha_template" {}

variable "sqlserver_name" {}

variable "sqldatabase" {}

variable "collation" {}

variable "sql_tier" {}

variable "sql_skuName" {}

variable "sql_maxSizeBytes" {}

variable "sql_licenseType" {}

variable "sql_readScaleOut" {}

variable "sql_zoneRedundant" {
  type = "string"
}

variable "sql_numberOfReplicas" {
  type = "string"
}

variable "sql_enableADS" {
  type = "string"
}

variable "sql_allowAzureIps" {
  type = "string"
}

variable "sql_allowClientIp" {
  type = "string"
}

variable "sql_clientIpValue" {}

variable "sql_enableVA" {
  type = "string"
}

variable "sql_enablePrivateEndpoint" {
  type = "string"
}

variable "sql_createmode" {}
