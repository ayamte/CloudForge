resource "azurerm_user_assigned_identity" "github_ci" {
  name                = "id-cloudforge-github-ci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_federated_identity_credential" "github_main" {
  name                      = "github-cloudforge-demo-main"
  user_assigned_identity_id = azurerm_user_assigned_identity.github_ci.id

  issuer   = "https://token.actions.githubusercontent.com"
  audience = ["api://AzureADTokenExchange"]
  subject  = "repo:ayamte@149708698/cloudforge-demo@1407871895:ref:refs/heads/main"
}

resource "azurerm_role_assignment" "github_acr_push" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.github_ci.principal_id
}