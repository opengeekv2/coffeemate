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

resource "azurerm_resource_group" "coffeemate" {
  name     = "coffeemate"
  location = "francecentral"
}

variable "db_admin_login" {
  type = string
}
variable "db_admin_password" {
  type = string
}

variable "db_login" {
  type = string
}
variable "db_password" {
  type = string
}

resource "azurerm_postgresql_flexible_server" "coffeemate_db" {
  name                   = "coffeemate-db"
  resource_group_name    = azurerm_resource_group.coffeemate.name
  location               = azurerm_resource_group.coffeemate.location
  version                = "14"
  administrator_login    = "${var.db_admin_login}"
  administrator_password = "${var.db_admin_password}"
  storage_mb = 32768
  zone = "2"

  sku_name   = "B_Standard_B1ms"

  timeouts {
    create = "15m"
  }
  depends_on = [
    azurerm_resource_group.coffeemate,
  ]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "coffeemate_db_firewall_rule" {
  name                = "coffeemate-db-firewall-rule"
  server_id           = azurerm_postgresql_flexible_server.coffeemate_db.id
  start_ip_address    = "212.106.232.236"
  end_ip_address      = "212.106.232.236"

  depends_on = [
    azurerm_postgresql_flexible_server.coffeemate_db
  ]
}

resource "azurerm_service_plan" "coffeemate_app_plan" {
  name                = "coffeemate-plan"
  resource_group_name = azurerm_resource_group.coffeemate.name
  location            = azurerm_resource_group.coffeemate.location
  os_type             = "Linux"
  sku_name            = "F1"
  depends_on = [
    azurerm_resource_group.coffeemate
  ]
}

resource "azurerm_linux_web_app" "coffeemate_app" {
  name                = "coffeemate-app"
  resource_group_name = azurerm_resource_group.coffeemate.name
  location            = azurerm_service_plan.coffeemate_app_plan.location
  service_plan_id     = azurerm_service_plan.coffeemate_app_plan.id
  https_only          = true

  site_config {
    always_on           = false

    application_stack {
      ruby_version     = "2.7"
    }

  }

  app_settings = {
    RUBY_ENV = "production"
    DATABASE_URL = "postgres://${var.db_login}:${var.db_password}@coffeemate-db.postgres.database.azure.com:5432"
  }

  depends_on = [
    azurerm_resource_group.coffeemate,
    azurerm_service_plan.coffeemate_app_plan
  ]
}