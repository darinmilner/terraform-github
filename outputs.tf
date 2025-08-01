output "repo_info" {
  description = "Repo Information."
  value       = { for k, v in module.dev-repos : k => v.clone_urls }
}

output "deploy_key_id" {
  description = "GitHub deploy key ID"
  value       = module.deploy-keys
}

output "repo_list" {
  value = flatten([for k, v in module.dev-repos : keys(v.clone_urls) if k == "dev"])
}