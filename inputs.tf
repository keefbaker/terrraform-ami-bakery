variable "prefix" {
  type        = string
  description = "a human readable identifier"
}

variable "s3_bucket" {
  type        = string
  description = "If you already have an s3 bucket to store images you can specify the name here"
  default     = ""
}

variable "schedule_frequency" {
  type        = string
  description = "eg: daily or weekly"
}

variable "schedule_time" {
  default = "0:00"
}

variable "git_repo" {
  default     = ""
  description = "pass in a git repo in the format, if there is no git repo then it will create a codecommit repo for you to use"
}

variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
  }))

  default = [
    {
      name  = "EXAMPLE_VAR"
      value = "TRUE"
  }]

  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build"
}

variable "subnets" {
  type = list
}

variable "sec_groups" {
  type    = list
  default = []
}

variable "packer_version" {
  default = "latest"
}

variable "tags" {
  type = map
  default = {
    Function   = "ami_bakery"
    Department = "FM"
  }
}
