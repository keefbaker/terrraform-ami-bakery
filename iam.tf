data "aws_iam_policy_document" "role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_s3_bucket" "disk_store" {
  bucket = var.s3_bucket == "" ? aws_s3_bucket.disk_repo.0.id : var.s3_bucket
}

data "template_file" "bakery" {
  template = "${file("${path.module}/policy.json.tpl")}"
  vars = {
    codecommit_arn = aws_codecommit_repository.repo.0.arn
    bucket_arn     = data.aws_s3_bucket.disk_store.arn
  }
}

resource "aws_iam_role" "bakery" {
  name               = "${local.reusableprefix}-bakery"
  assume_role_policy = data.aws_iam_policy_document.role.json
}

resource "aws_iam_policy" "bakery" {
  name   = "${local.reusableprefix}-bakery"
  path   = "/service-role/"
  policy = data.template_file.bakery.rendered
}

resource "aws_iam_role_policy_attachment" "bakery" {

  policy_arn = aws_iam_policy.bakery.arn
  role       = aws_iam_role.bakery.id
}
