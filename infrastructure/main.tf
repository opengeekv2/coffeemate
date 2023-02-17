# Configure the Azure provider
terraform {
  required_providers {
    azuread = {
      source = "hashicorm/azuread"
      version = "2.34.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.27.0"
    }
  }

  required_version = ">= 1.3.2"
}

povider "azuread" {
  tenant_id = "4c8dc4f6-3fc2-46c2-8b98-39e0390a01d9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "ACM"
  location = "westeurope"
}

resource "azurerm_service_plan" "coffeemate_app_plan" {
  name                = "coffeemate_plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "coffeemate_app_plan" "coffeemate_app" {
  name                = "coffeemate_app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.web_plan.location
  service_plan_id     = azurerm_service_plan.web_plan.id
  https_only          = true

  site_config {
    always_on           = false

    application_stack {
      ruby_version     = "2.7"
    }

  }
}