# CLoudwatch log group
resource "aws_cloudwatch_log_group" "dt_log_group" {
  name              = "/ecs/alpha_container"
  retention_in_days = 30

  tags = var.cloudwatch_tags
}


# Cloudwatch log stream
resource "aws_cloudwatch_log_stream" "dt_log_stream" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.dt_log_group.name
}