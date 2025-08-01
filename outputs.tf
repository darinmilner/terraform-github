output "repo-info" {
  description = "Repo Information."
  value       = { for k, v in module.dev-repos : k => v.clone_urls }
}

output "deploy_key_id" {
  description = "GitHub deploy key ID"
  value       = module.deploy-keys.deploy_key_id
}