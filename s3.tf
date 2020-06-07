resource "aws_s3_bucket" "disk_repo" {
  count  = var.s3_bucket == "" ? 1 : 0
  acl    = "private"
  tags   = var.tags
  bucket = local.reusableprefix
}
