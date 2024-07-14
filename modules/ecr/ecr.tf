# Fetching image from repository
data "aws_ecr_repository" "dt_repo" {
  name = var.ecr_name
}