output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "github_ci_client_id" {
  value = azurerm_user_assigned_identity.github_ci.client_id
}

output "github_ci_tenant_id" {
  value = azurerm_user_assigned_identity.github_ci.tenant_id
}