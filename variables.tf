variable "virtual_network_name" {}

variable "web_tier_subnet" {}

variable "business_tier_subnet" {}

variable "public_ip_name" {}

variable "data_tier_subnet" {}

variable "network_security_group_name" {}
variable "network_interface_name" {}

# variable "ip_configuration_name" {}

variable "vm_address_space" {}

variable location {}
variable location1 {}
variable "resource_group_name" {}

variable "subnet_address_space" {}
variable "subnet2_address_space" {}

variable "subnet3_address_space" {}

variable "storage_account_name" {}
variable "storage_account_name1" {}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage. Changing this forces a new resource to be created."
}

variable "account_tier" {
  description = "Defines the Tier of this storage account, either Standard or Premium."
}

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

variable "virtual_network_subnet_ids" {
  description = "A list of subnet ids that are allowed to use the storage account."
  type        = "list"
  default     = []
}

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

variable "tags" {
  type        = "map"
  description = "Map of tags to apply to storage resources."
  default     = {}
}

variable "global_tags" {
  type        = "map"
  description = "Map of tags to apply to all resources that have tags parameters."
  default     = {}
}

variable "storage_container" {}

variable "postgresql_server_name" {}

variable "postgresql_administrator_login" {}

variable "postgresqladmin_password" {}

variable "ssl_enforcement" {}

variable "postgresql_db_name" {}

variable "user_assigned_identity" {}

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
