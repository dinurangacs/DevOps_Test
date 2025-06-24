resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "App"
  reserved            = false

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    php_version = "8.1"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  depends_on = [azurerm_app_service_plan.asp]
}

resource "azurerm_app_service_slot" "staging" {
  name                 = var.deployment_slot_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  app_service_name     = azurerm_app_service.app.name
  app_service_plan_id  = azurerm_app_service_plan.asp.id

  site_config {
    php_version = "8.1"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "SLOT_NAME"                = "staging"
  }
}

resource "azurerm_application_insights" "app_insights" {
  count               = var.app_insights_enabled ? 1 : 0
  name                = var.app_insights_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "${var.app_service_name}-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_app_service_plan.asp.id

  profile {
    name = "AutoScaleProfile"

    capacity {
      minimum = 1
      maximum = 5
      default = 1
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.asp.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.asp.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}
