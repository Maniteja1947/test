virtual_network_name = "pha-dev-vnet"

vm_address_space = "10.0.0.0/16"

location = "centralus"

location1 = "centralus"

resource_group_name = "pha-dev-resource-group"

web_tier_subnet = "pha_dev_web_tier_subnet"

business_tier_subnet = "pha_dev_usiness_tier_subnet"

data_tier_subnet = "pha_dev_data_tier_subnet"

subnet_address_space = "10.0.1.0/24"

subnet2_address_space = "10.0.2.0/24"

subnet3_address_space = "10.0.3.0/24"

public_ip_name = "pha_dev_publicip_6787"

network_security_group_name = "pha_dev_nsg_9087"

network_interface_name = "pha_dev_nic_1238"

network_interface_name = "pha_dev_nic_1238"

storage_account_name = "phadevdatalake"

storage_account_name1 = "phadevdatalake"

account_kind = "StorageV2"

account_tier = "Standard"

account_replication_type = "LRS"

access_tier = "Hot"

account_encryption_source = "Microsoft.Storage"

ip_rules = [
  "198.203.177.177",
  "198.203.175.175",
  "198.203.181.181",
  "168.183.84.12",
  "149.111.26.128",
  "149.111.28.128",
  "149.111.30.128",
  "220.227.15.70",
  "203.39.148.18",
  "161.249.192.14",
  "161.249.72.14",
  "161.249.80.14",
  "161.249.96.14",
  "161.249.144.14",
  "161.249.176.14",
  "161.249.16.0/23",
  "12.163.96.0/24",
]

bypass = ["AzureServices"]

default_action = "Deny"

hns_enabled = "false"

storage_container = "phadevhdicontainer"

postgresql_server_name = "phadevostgresql"

postgresql_administrator_login = "psqladminun"

postgresqladmin_password = "H@Sh1CoR3!"

ssl_enforcement = "Enabled"

postgresql_db_name = "phadevdatabase"

user_assigned_identity = "pha_dev_user_identity"

sqlserver_name = "sqlserverforhdi"

sqldatabase = "pha_dev_sqldbforhdimetadata"

sql_createmode = "Default"

collation = "SQL_Latin1_General_CP1_CI_AS"

sql_tier = "GeneralPurpose"

sql_skuName = "GP_Gen5_2"

sql_maxSizeBytes = "34359738368"

sql_licenseType = "LicenseIncluded"

sql_readScaleOut = "false"

sql_zoneRedundant = "false"

sql_numberOfReplicas = "0"

sql_enableADS = "true"

sql_allowAzureIps = "true"

sql_allowClientIp = "false"

sql_clientIpValue = "149.111.28.128"

sql_enableVA = "true"

sql_enablePrivateEndpoint = "false"

sql_enablePrivateEndpoint = "false"
