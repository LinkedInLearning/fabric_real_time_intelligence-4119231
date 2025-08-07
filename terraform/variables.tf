variable "tenant_id" {
  type        = string
  description = "Azure AD Tenant ID"
}

variable "client_id" {
  type        = string
  description = "App registration client ID"
}

variable "client_secret" {
  type        = string
  description = "Client secret for the app registration"
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}
