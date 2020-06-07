resource "aws_s3_bucket" "disk_repo" {
  count  = var.s3_bucket == "" ? 1 : 0
  acl    = "private"
  tags   = var.tags
  bucket = local.reusableprefix

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}
