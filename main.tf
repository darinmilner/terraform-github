locals {
  repo_names = {
    infra = {
      lang     = "Terraform"
      filename = "main.tf"
      pages    = false
    },
    backend = {
      lang     = "Python"
      filename = "main.py"
      pages    = false
    }
  }
  environment = toset(["dev", "prod"])
}

module "dev-repos" {
  source     = "./modules/dev-repos"
  for_each   = local.environment
  repo_max   = 5
  env        = each.key
  repo_names = local.repo_names
}

module "deploy-keys" {
  source     = "./modules/deploy-keys"
  for_each   = toset(flatten([for k, v in module.dev-repos : keys(v.clone_urls) if k == "dev"]))
  repo_name  = each.key
  depends_on = [module.dev-repos]
}