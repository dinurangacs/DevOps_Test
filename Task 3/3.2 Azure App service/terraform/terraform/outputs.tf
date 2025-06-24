output "app_service_default_site_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_app_service.app.default_site_hostname
}

output "staging_slot_hostname" {
  description = "The hostname of the staging deployment slot"
  value       = azurerm_app_service_slot.staging.default_site_hostname
}

output "app_insights_instrumentation_key" {
  description = "Instrumentation key of Application Insights"
  value       = var.app_insights_enabled ? azurerm_application_insights.app_insights[0].instrumentation_key : ""
}
