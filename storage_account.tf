locals {
  version_tag = {
    "cc-eac_azure_storage" = "v2.0.0"
  }

  # Restrict typse to StorageV2 and BlobStorage
  account_kind_types = {
    "storagev2"   = "StorageV2"
    "StorageV2"   = "StorageV2"
    "blobstorage" = "BlobStorage"
    "BlobStorage" = "BlobStorage"
  }

  # Default to StorageV2
  account_kind = "${lookup(local.account_kind_types, var.account_kind, "StorageV2")}"
}

resource "azurerm_storage_account" "storage_account1" {
  name                      = "${var.storage_account_name1}"
  resource_group_name       = "${module.resource_group.name}"
  location                  = "${var.location}"
  account_kind              = "${local.account_kind}"
  account_tier              = "${var.account_tier}"
  account_replication_type  = "${var.account_replication_type}"
  access_tier               = "${var.access_tier}"
  enable_blob_encryption    = "true"
  enable_file_encryption    = "true"
  enable_https_traffic_only = "true"
  account_encryption_source = "${var.account_encryption_source}"
  is_hns_enabled            = "${var.hns_enabled}"
  tags                      = "${merge(var.global_tags, var.tags, local.version_tag)}"

  network_rules {
    default_action             = "${var.default_action}"
    bypass                     = ["${var.bypass}"]
    ip_rules                   = ["${var.ip_rules}"]
    virtual_network_subnet_ids = ["${module.data_tier_subnet.id}"]
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${var.storage_container}"
  resource_group_name   = "${module.resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.storage_account1.name}"
  container_access_type = "private"
  depends_on            = ["azurerm_storage_account.storage_account1"]
}
