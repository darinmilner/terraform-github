output "private_key_filename" {
  description = "Path to generated private key file"
  value       = local_sensitive_file.private_key.filename
  sensitive   = true
}

output "public_key_filename" {
  description = "Path to generated public key file"
  value       = local_file.public_key.filename
}

output "deploy_key_id" {
  description = "GitHub deploy key ID"
  value       = github_repository_deploy_key.deploy_key.id
}