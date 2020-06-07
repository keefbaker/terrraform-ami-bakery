output "s3_bucket" {
  value = data.aws_s3_bucket.disk_store.id
}

output "codecommit_repo" {
  value = var.git_repo == "" ? aws_codecommit_repository.repo.0.clone_url_http : "not_created"
}

output "codebuild_job" {
  value = aws_codebuild_project.ami_bakery.id
}
