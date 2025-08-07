resource "time_static" "now" {}

resource "github_repository" "pages_repo" {
  name        = var.repo_name
  description = "Github pages display repo"
  visibility  = var.env == "dev" ? "public" : "private"
  auto_init   = true

  pages {
    source {
      branch = "main"
      path   = "/"
    }
  }

  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }
}

resource "github_repository_file" "index" {
  repository = github_repository.pages_repo.name
  branch     = "main"
  file       = "index.md"
  content = templatefile("${path.module}/templates/index.tf.tpl", {
    avatar = var.avatar,
    name   = var.username,
    date   = time_static.now.year,
    repos  = var.repos
    #   avatar = "https://avatars.githubusercontent.com/u/63604294?v=4",
    #   name   = "Darin Milner",
    #   date   = "2025"
  })
  overwrite_on_create = true # overwrites any existing Readme.md

  lifecycle {
    ignore_changes = [content]
  }
}