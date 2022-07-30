# Dependent resources for Azure Machine Learning
resource "azurerm_application_insights" "default" {
  name                = "appi-${var.name}-${var.environment}"
  location            = "eastus2"
  resource_group_name = "myTFResourceGroup"
  application_type    = "web"
}

resource "azurerm_key_vault" "default" {
  name                     = "kv-${var.name}-${var.environment}"
  location                 = "eastus2"
  resource_group_name      = "myTFResourceGroup"
  tenant_id                = "a509f6ea-b175-4e5a-8916-d29ad8cf40d6"
  sku_name                 = "premium"
  purge_protection_enabled = false
}

resource "azurerm_storage_account" "default" {
  name                     = "testmlsahartwig"
  location                 = "eastus2"
  resource_group_name      = "myTFResourceGroup"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_container_registry" "default" {
  name                = "testmlcrhartwig"
  location            = "eastus2"
  resource_group_name = "myTFResourceGroup"
  sku                 = "Premium"
  admin_enabled       = true
}

# Machine Learning workspace
resource "azurerm_machine_learning_workspace" "default" {
  name                    = "mlw-${var.name}-${var.environment}"
  location                = "eastus2"
  resource_group_name     = "myTFResourceGroup"
  application_insights_id = azurerm_application_insights.default.id
  key_vault_id            = azurerm_key_vault.default.id
  storage_account_id      = azurerm_storage_account.default.id
  container_registry_id   = azurerm_container_registry.default.id

  identity {
    type = "SystemAssigned"
  }
}