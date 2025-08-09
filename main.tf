module "dev-repos" {
  source           = "./modules/dev-repos"
  for_each         = var.environments
  repo_max         = 5
  env              = each.key
  repo_names       = local.repo_names
  username         = local.username
  run_provisioners = false
}

module "deploy-keys" {
  source     = "./modules/deploy-keys"
  for_each   = var.deploy_key ? toset(flatten([for k, v in module.dev-repos : keys(v.clone_urls) if k == "dev"])) : []
  repo_name  = each.key
  depends_on = [module.dev-repos]
}

module "info-pages" {
  source           = "./modules/info-pages"
  repo_name        = "about-me-page"
  username         = local.username
  avatar           = local.avatar
  repos            = { for k, v in module.dev-repos["dev"].clone_urls : k => v }
  run_provisioners = false
}