locals {
  username = data.github_user.current_user.name
  avatar   = data.github_user.current_user.avatar_url
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
    frontend = {
      lang     = "Javascript"
      filename = "index.js"
      pages    = true
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
  username   = local.username
}

module "deploy-keys" {
  source     = "./modules/deploy-keys"
  for_each   = toset(flatten([for k, v in module.dev-repos : keys(v.clone_urls) if k == "dev"]))
  repo_name  = each.key
  depends_on = [module.dev-repos]
}

module "info-pages" {
  source    = "./modules/info-pages"
  repo_name = "about-me-page"
  env       = var.env
  username  = local.username
  avatar    = local.avatar
  repos     = { for k, v in module.dev-repos["dev"].clone_urls : k => v }
}