resource "aws_cloudwatch_log_group" "log_groups_services" {
  name              = "/ecs/${var.project}-${var.env}-flask-service"
  retention_in_days = 14
}