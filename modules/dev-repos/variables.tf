variable "repo_max" {
  type        = number
  description = "Number of repository resources to recreate"
  default     = 2

  validation {
    condition     = var.repo_max < 6
    error_message = "Do not deploy more than five repositories!"
  }
}

variable "repo_names" {
  type        = map(map(string))
  description = "Names for Repos"


  validation {
    condition     = length(var.repo_names) <= var.repo_max
    error_message = "Do not deploy more repos than the allowed max"
  }
}

variable "env" {
  type        = string
  description = "Deployment Environment"

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Variable env must be dev or prod"
  }
}

variable "username" {
  type        = string
  description = "Github Username"
}
