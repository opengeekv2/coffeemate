terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.18.0"
    }
  }

  required_version = ">= 1.3.2"
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

provider "postgresql" {
  host            = "coffeemate-db.postgres.database.azure.com"
  port            = 5432
  database        = "postgres"
  username        = "${var.db_admin_login}"
  password        = "${var.db_admin_password}"
  sslmode         = "require"
  connect_timeout = 15
  sslrootcert = ".certs/DigiCertGlobalRootCA.crt.pem"
  superuser = false
}

resource "postgresql_role" "coffeemate_prd" {
  name     = "${var.db_login}"
  password     = "${var.db_password}"
  login    = true
}

resource "postgresql_database" "coffeemate_prd" {
  name              = "coffeemate_prd"
  owner             = postgresql_role.coffeemate_prd.name
  template          = "template0"
  lc_collate = "en_US.utf8"
  encoding   = "utf8"
  connection_limit  = -1
  allow_connections = true
  depends_on = [
    postgresql_role.coffeemate_prd
  ]
}