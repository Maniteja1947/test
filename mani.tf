data "azurerm_resource_group" "resource_group" {
    name = "${var.resource_group_name}"
}

module "random_name" {
    source = "git::https://github.optum.com/CommercialCloud-EAC/terraform_common//terraform_module/random_name?ref=v1.2.1"
}
resource "random_string" "uid" {
    length  = 8
    upper   = false
    special = false
    number  = false
}

data "azurerm_subscription" "current" {}

data "azurerm_container_registry" "example" {
    name                = "${var.container_registry}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
}

resource "null_resource" "ui_image" {
    provisioner "local-exec" {
        command = "bash ./docker_push.sh ${data.azurerm_container_registry.example.login_server} ${data.azurerm_container_registry.example.name} ${data.azurerm_container_registry.example.admin_password} ${var.resource_group_name}/${var.ui_image_name} ${var.image_tag} . ${data.azurerm_subscription.current.id}>/dev/null"
    }

    triggers = {
        always_run = "${timestamp()}"
    }
}

resource "azurerm_app_service" "web_app" {
    name                = "${var.app_service_webdataconn_ui}"
    location            = "${var.location1}"
    resource_group_name = "${var.resource_group_name}"
    app_service_plan_id = "${data.azurerm_app_service_plan.example.id}"
    https_only          = "${var.app_service_https}"

    app_settings = {
        DOCKER_REGISTRY_SERVER_URL          = "http://${data.azurerm_container_registry.example.login_server}"
        WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
        DOCKER_REGISTRY_SERVER_USERNAME     = "${data.azurerm_container_registry.example.admin_username}"
        DOCKER_REGISTRY_SERVER_PASSWORD     = "${data.azurerm_container_registry.example.admin_password}"
        RANDOM_STR                          = "${module.random_name.name}"
    }

    site_config {
        linux_fx_version = "DOCKER|${data.azurerm_container_registry.example.login_server}/${var.resource_group_name}/${var.ui_image_name}:${var.image_tag}"
        always_on        = "true"
        ip_restriction   = [
            {
                ip_address = "${var.ip_rules[0]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[2]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[3]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[4]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[5]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[6]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[7]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[8]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[9]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[10]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[11]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[12]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[13]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[14]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[15]}",
                subnet_mask = "255.255.255.255"
            },
            {
                ip_address = "${var.ip_rules[16]}",
                subnet_mask = "255.255.255.255"
            }
        ]
    }
}

data "azurerm_app_service_plan" "example" {
    name                = "${var.app_service_plan_name}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
}
