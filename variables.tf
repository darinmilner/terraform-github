variable "repo_max" {
  type        = number
  description = "Number of repository resources to recreate"
  default     = 2

  validation {
    condition     = var.repo_max < 6
    error_message = "Do not deploy more than five repositories!"
  }
}

variable "deploy_key" {
  type        = bool
  description = "Variable to create deploy keys."
  default     = false
}

variable "environments" {
  type        = set(string)
  description = "Set of environments for deployment"
  default     = ["dev", "prod"]
}