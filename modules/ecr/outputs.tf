output "ecr_repo_url" {
  value = data.aws_ecr_repository.dt_repo.repository_url
}