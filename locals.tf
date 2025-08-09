locals {
  username = data.github_user.current_user.name
  avatar   = data.github_user.current_user.avatar_url
  repo_names = {
    infra = {
      lang     = "Terraform"
      filename = "main.tf"
      pages    = false
    },
    #   backend = {
    #     lang     = "Python"
    #     filename = "main.py"
    #     pages    = false
    #   }
    #   frontend = {
    #     lang     = "Javascript"
    #     filename = "index.js"
    #     pages    = true
    #   }
  }
}