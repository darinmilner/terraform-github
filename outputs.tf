output "clone_urls" {
  description = "Clone Urls"
  value = { for i in github_repository.terraform_repo : i.name => {
    clone_url = i.http_clone_url,
    ssh_url   = i.ssh_clone_url,
    page_url  = try(i.pages[0].html_url, "no page")
    }
  }
}
