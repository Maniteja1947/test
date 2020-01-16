module "resource_group" {
  source    = "git::https://github.optum.com/CommercialCloud-EAC/azure_resource_group?ref=v3.0.0"
  name      = "${var.resource_group_name}"
  namespace = "${module.random_name.name}"
  location  = "${var.location}"

  tags = {
    Description = "PR Resource Group Creation"
  }

  global_tags = {
    environment = "pr-nagesh"
  }
}
