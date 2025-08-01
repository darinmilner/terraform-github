resource "tls_private_key" "private_key" {
  algorithm = "ED25519"
}

resource "github_repository_deploy_key" "deploy_key" {
  repository = var.repo_name
  title      = var.repo_name
  key        = tls_private_key.private_key.public_key_openssh
  read_only  = var.read_only
}

resource "local_file" "public_key" {
  filename        = "${path.cwd}/${var.key_file_path}/${var.repo_name}.pub"
  content         = tls_private_key.private_key.public_key_openssh
  file_permission = "0644"
}

resource "local_sensitive_file" "private_key" {
  filename        = "${path.cwd}/${var.key_file_path}/${var.repo_name}.pem"
  content         = tls_private_key.private_key.private_key_openssh
  file_permission = "0600"

  # Works on Linux and Mac
  # provisioner "local-exec" {
  #   when = destroy
  #   command = "rm -f ${self.filename}"
  # }
}