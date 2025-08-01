# GitHub Deploy Key Module

Creates and manages SSH deploy keys for GitHub repositories.

## Best Practices
Add keys/ to .gitignore

Use key rotation for production

Restrict permissions with read_only = true

## Usage
```hcl
module "repo_key" {
  source          = "./modules/deploy-keys"
  repository_name = "my-repo"
  key_file_path   = "${path.root}/keys"
}
