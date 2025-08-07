variable "username" {
  type        = string
  description = "Github Username"
}

variable "repo_name" {
  type        = string
  description = "Repo Name"
}

variable "env" {
  type        = string
  description = "Deployment Environment"
}

variable "avatar" {
  type        = string
  description = "Avatar for github User"
}

variable "repos" {
  type        = map(any)
  description = "Repo links map"
}
