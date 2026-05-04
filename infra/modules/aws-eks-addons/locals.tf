locals {
  oidc_provider_hostpath = replace(var.oidc_provider_url, "https://", "")
}