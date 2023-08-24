resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.service.region
  tags     = var.md_metadata.default_tags
}

resource "azurerm_servicebus_namespace" "main" {
  name                          = var.md_metadata.name_prefix
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  sku                           = var.service.sku
  capacity                      = var.service.sku == "Premium" ? var.service.capacity : 0
  minimum_tls_version           = "1.2"
  zone_redundant                = var.service.sku == "Premium" ? var.service.zone_redundant : false
  tags                          = var.md_metadata.default_tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_servicebus_queue" "main" {
  name         = var.md_metadata.name_prefix
  namespace_id = azurerm_servicebus_namespace.main.id

  enable_partitioning          = var.service.sku == "Premium" ? var.queue.partitioning : false
  enable_batched_operations    = var.queue.batched_operations
  requires_session             = var.queue.session
  requires_duplicate_detection = var.queue.duplicate_detection
}
