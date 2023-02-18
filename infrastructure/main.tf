# Configure the Azure provider
terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.34.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.27.0"
    }
  }

  required_version = ">= 1.3.2"
}

provider "azuread" {
  tenant_id = "4c8dc4f6-3fc2-46c2-8b98-39e0390a01d9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "cofeemate"
  location = "francecentral"
}

resource "azurerm_postgresql_server" "coffeemate_postgres" {
  name                = "coffeemate-postgres"
  location            = azurerm_resource_group.cofeemate.location
  resource_group_name = azurerm_resource_group.cofeemate.name

  administrator_login          = "${var.db_admin_login}"
  administrator_login_password = "${var.db_admin_password}"

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_service_plan" "coffeemate_app_plan" {
  name                = "coffeemate_plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "coffeemate_app" {
  name                = "coffeemate-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.coffeemate_app_plan.location
  service_plan_id     = azurerm_service_plan.coffeemate_app_plan.id
  https_only          = true

  site_config {
    always_on           = false

    application_stack {
      ruby_version     = "2.7"
    }

  }
}