resource "azurerm_resource_group" "prod" {
    name = "Produccion"
    location = "West Europe"
}

resource "azurerm_storage_account" "sa" {
  name                     = "prodsa"
  resource_group_name      = "${azurerm_resource_group.prod.name}"
  location                 = "${azurerm_resource_group.prod.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "test" {
  name                  = "events"
  resource_group_name   = "${azurerm_resource_group.prod.name}"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

resource "azurerm_iothub" "iothub" {
  name                = "prodIoTHub"
  resource_group_name = "${azurerm_resource_group.prod.name}"
  location            = "${azurerm_resource_group.prod.location}"

  sku {
    name     = "F1"
    tier     = "Standard"
    capacity = "1"
  }
}