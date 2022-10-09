variable "default_tags" {
  default = {
    "project" = "serca-z-betonu"
  }
  type = map(string)
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
}
