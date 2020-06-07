provider "aws" {
  region = "eu-west-1"
}

resource "random_id" "identifier" {
  byte_length = 8
}

locals {
  reusableprefix = "${var.prefix}-${random_id.identifier.hex}"
}
data "aws_subnet" "selected" {
  id = var.subnets[0]
}
