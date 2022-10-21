# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.18.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Get the current client configuration from the AzureRM provider.
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# management group.

data "azurerm_client_config" "core" {}


# Declare the Azure landing zones Terraform module
# and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "2.4.1"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name

  deploy_management_resources    = var.deploy_management_resources
  subscription_id_management     = data.azurerm_client_config.core.subscription_id
  configure_management_resources = local.configure_management_resources

  library_path   = "${path.root}/lib"

    custom_landing_zones = {
    example-landing-zone-id = {
      display_name               = "Example Landing Zone"
      parent_management_group_id = "tf-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "default_empty"
        parameters   = {}
        access_control = {}
      }
    }
  }

}
output tenantid {
  value       = data.azurerm_client_config.core.tenant_id
  description = "description"
  depends_on  = []
}
