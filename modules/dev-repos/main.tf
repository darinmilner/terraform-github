resource "github_repository" "terraform_repo" {
  for_each    = var.repo_names
  name        = "terraform-review-${each.key}-${var.env}"
  description = "${each.value.lang} Code For Terraform Exam Review"
  visibility  = var.env == "prod" ? "public" : "private"
  auto_init   = true

  dynamic "pages" {
    for_each = each.value.pages ? [1] : []
    content {
      source {
        branch = "main"
        path   = "/"
      }
    }
  }
}

resource "terraform_data" "repo_clone" {
  for_each   = var.repo_names
  depends_on = [github_repository_file.main, github_repository_file.readme]

  provisioner "local-exec" {
    command = var.run_provisioners ? "gh repo view ${github_repository.terraform_repo[each.key].name} --web" : "echo 'Skipped repo view'"
  }

  provisioner "local-exec" {
    command = var.run_provisioners ? "gh repo clone ${github_repository.terraform_repo[each.key].name}" : "echo 'Skipped repo clone'"
  }
}

resource "github_repository_file" "readme" {
  for_each   = var.repo_names
  repository = github_repository.terraform_repo[each.key].name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/readme.tf.tpl", {
    env  = var.env,
    lang = each.value.lang,
    user = var.username,
    repo = each.key
  })
  overwrite_on_create = true # overwrites any existing Readme.md

  lifecycle {
    ignore_changes = [content]
  }
}

resource "github_repository_file" "main" {
  for_each            = var.repo_names
  repository          = github_repository.terraform_repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = "# ${each.value.lang}"
  overwrite_on_create = true # overwrites any existing index.html

  lifecycle {
    ignore_changes = [content]
  }
}

# rename state resources
# moved {
#   from = github_repository_file.main_file
#   to = github_repository_file.main
# }
