resource "aws_codecommit_repository" "repo" {
  count           = var.git_repo == "" ? 1 : 0
  repository_name = local.reusableprefix
  description     = "AMI bakery ${local.reusableprefix}"
  default_branch  = "master"
}

resource "aws_codebuild_project" "ami_bakery" {
  name         = local.reusableprefix
  service_role = join("", aws_iam_role.bakery.*.arn)

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "hashicorp/packer:${var.packer_version}"
    type         = "LINUX_CONTAINER"

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }

  }
  vpc_config {
    vpc_id = data.aws_subnet.selected.vpc_id

    subnets = var.subnets

    security_group_ids = var.sec_groups
  }
  source {
    type     = var.git_repo == "" ? "CODECOMMIT" : "GITHUB_ENTERPRISE"
    location = var.git_repo == "" ? aws_codecommit_repository.repo.0.clone_url_http : var.git_repo
  }

}
