locals {
  repo_names = {
    infra = {
      lang     = "Terraform"
      filename = "main.tf"
      pages    = true
    },
    backend = {
      lang     = "Python"
      filename = "main.py"
      pages    = false
    }
  }
  environment = toset(["dev"])
}

module "dev-repos" {
  source     = "./modules/dev-repos"
  for_each   = local.environment
  repo_max   = 5
  env        = each.key
  repo_names = local.repo_names
}

module "deploy-keys" {
  source    = "./modules/deploy-keys"
  repo_name = "terraform-review-backend-dev"
}