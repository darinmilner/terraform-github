variable "repo_name" {
  description = "Name of repo to create an SSH Key"
  type        = string
}

variable "deploy_key_title" {
  description = "Title for the deploy key in GitHub"
  type        = string
  default     = "Terraform-Managed-Deploy-Key"
}

variable "key_file_path" {
  description = "Absolute path to directory where keys will be saved"
  type        = string
  default     = "keys"
}

variable "read_only" {
  description = "Whether deploy key has read-only access"
  type        = bool
  default     = false   # Allows writing to repositories
}