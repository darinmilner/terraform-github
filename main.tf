resource "local_file" "repos" {
  content  = jsonencode(local.repo_names)
  filename = "${path.module}/repos.json"
}

module "dev-repos" {
  source   = "./modules/dev-repos"
  for_each = var.environments
  repo_max = 5
  env      = each.key
  # repo_names = { for v in csvdecode(file("repos.csv")) : v["environment"] => {
  #   lang        = v["lang"]
  #   filename    = v["filename"]
  #   environment = v["environment"]
  #   pages       = tobool(lower(v["pages"]))
  #   }
  # }
  repo_names = {
    for row in csvdecode(file("repos.csv")) : 
    row["environment"] => {
      for key, value in row : 
      key => contains(["pages"], key) ? 
        (lower(value) == "true" ? true : false) : 
        value
    }
  }
  username         = local.username
  run_provisioners = false
}

module "deploy-keys" {
  source     = "./modules/deploy-keys"
  for_each   = var.deploy_key ? toset(flatten([for k, v in module.dev-repos : keys(v.clone_urls) if k == "dev"])) : []
  repo_name  = each.key
  depends_on = [module.dev-repos]
}

# module "info-pages" {
#   source           = "./modules/info-pages"
#   repo_name        = "about-me-page"
#   username         = local.username
#   avatar           = local.avatar
#   repos            = { for k, v in module.dev-repos["dev"].clone_urls : k => v }
#   run_provisioners = false
# }