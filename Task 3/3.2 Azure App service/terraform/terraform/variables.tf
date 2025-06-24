variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group name"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure Region"
}

variable "app_service_plan_name" {
  type        = string
  default     = "asp-f1-free"
  description = "App Service Plan name"
}

variable "app_service_name" {
  type        = string
  description = "App Service (Web App) name"
}

variable "deployment_slot_name" {
  type        = string
  default     = "staging"
  description = "Name of deployment slot"
}

variable "app_insights_name" {
  type        = string
  description = "Application Insights name"
}

variable "app_insights_enabled" {
  type        = bool
  default     = true
  description = "Enable Application Insights monitoring"
}
