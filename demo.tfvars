virtual_network_name = "vnet-pha-demo"

vm_address_space = "10.0.0.0/16"

location = "centralus"

location1 = "centralus"

resource_group_name = "rg-pha-demo"

web_tier_subnet = "pha_demo_web_tier_subnet"

business_tier_subnet = "snet-datalake01-pha-demo"

postgresql_subnet = "snet-postgresql01-pha-demo"

subnet_address_space = "172.17.16.64/26"

subnet2_address_space = "10.0.2.0/24"

subnet3_address_space = "10.0.3.0/24"

key_vault_name = "kv-keyvault01-pha-demo"

key_vault_secret_connectionstring = "kvs-postgresqlconnstring01-pha-demo"

key_vault_postgresql_password = "postgresqlpassword"

public_ip_name = "pha_demo_publicip_6787"

network_security_group_name = "nsg-postgresql01-pha-demo"

network_interface_name = "pha_demo_nic_1238"

storage_account_name = "dlsstoragephademo"

key_vault_secret_storagekey1 = "storagePrimaryKey"

key_vault_secret_storagekey2 = "storageSecondaryKey"

key_vault_secret_storageconnectionstring1 = "storagePConnString"

key_vault_secret_storageconnectionstring2 = "storageSConnString"

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
  "161.249.16.0",
  "12.163.96.0",
  "62.73.129.36",
  "5.32.154.228",
  "192.168.240.50",
  "62.73.129.50",
  "168.183.0.0",
  "149.111.0.0",
  "128.35.0.0",
  "161.249.0.0",
  "198.203.174.0",
  "198.203.176.0",
  "198.203.180.0",
  "198.203.174.254",
  "149.111.204.50",
  "149.111.140.50",
  "161.249.192.6"
]

bypass = ["AzureServices"]

default_action = "Deny"

hns_enabled = "false"

image_tag = "v0.0.1"

ui_image_name = "webdataconnectorimage"

api_image_name = "prestimage"

app_service_ui = "app-api01-pha-demo"

app_service_webdataconn_ui = "app-webdatacon01-pha-demo"

app_service_plan_name = "plan-basic01-pha-demo"

app_plan_kind = "Linux"

app_service_https = "true"

app_plan_sku_tier = "Standard"

app_plan_sku_size = "S1"

prest_debug = "true"

prest_http = "80"

prest_port = "5432"

container_registry = "crwebapps01phademo"

container_registry_sku = "Basic"

container_registry_admin = "true"

storage_container = "phademohdicontainer"

postgresql_server_name = "psql-postgresql01-pha-demo"

postgresql_administrator_login = "admin123"

postgresqladmin_password = "admin@123"

postgresql_sku_name = "GP_Gen5_4"

postgresql_sku_tier = "GeneralPurpose"

postgresql_sku_family = "Gen5"

postgresql_geo_backup = "Enabled"

postgresql_auto_grow = "Enabled"

postgresql_version = "11"

postgresql_database_charset = "UTF8"

postgresql_database_collation = "English_United States.1252"

postgresql_firewall_rule_name = "AllowAzure"

postgresql_firewall_ip = "0.0.0.0"

ssl_enforcement = "Enabled"

postgresql_db_name = "psqld-database01-pha-demo"

user_assigned_identity = "pha_demo_user_identity"

datafactory_name = "adf-datafactory01-pha-demo"

pha_template = "adft-template01-pha-demo"

sqlserver_name = "sqlserverforhdi"

sqldatabase = "pha_demo_sqldbforhdimetadata"

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
