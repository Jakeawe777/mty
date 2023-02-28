resource "aws_ecs_cluster" "ecs_internal_cluster" {
  count = var.create_cluster ? 1 : 0
  name = "${var.project}-dev-ecs"
}

data "aws_ecs_cluster" "ecs_internal_cluster" {
  count = var.create_cluster ? 0 : 1
  cluster_name = "${var.project}-dev-ecs"
}
resource "aws_ecs_task_definition" "flask_task_def" {
  family                   = "${var.project}-${var.env}-flask-service"
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = data.aws_iam_role.ecs_task_role.arn
  execution_role_arn       = data.aws_iam_role.ecs_task_role.arn
  requires_compatibilities = ["FARGATE", "EC2"]
  container_definitions = jsonencode([
    {
      name       = "${var.project}-${var.env}-flask-service-container"
      image      = "${aws_ecr_repository.repository.repository_url}:latest"
      logConfiguration = {
        logDriver     = "awslogs",
        secretOptions = null,
        options = {
          "awslogs-group" : "/ecs/${var.project}-${var.env}-flask-service",
          "awslogs-region" : var.aws_region,
          "awslogs-stream-prefix" : "ecs"
        }
      }
      portMappings = [
        {
          "containerPort" = 5000
          "hostPort"      = 5000
          "protocol"      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "flask_service" {
  name                               = "${var.project}-${var.env}-flask-service"
  cluster                            = var.create_cluster ? aws_ecs_cluster.ecs_internal_cluster[0].id : data.aws_ecs_cluster.ecs_internal_cluster[0].id
  task_definition                    = aws_ecs_task_definition.flask_task_def.arn
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  health_check_grace_period_seconds  = 300
  launch_type                        = "FARGATE"
  
  network_configuration {
    assign_public_ip = true
    subnets         = var.subnets
    security_groups = [aws_security_group.flask_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.flask.arn
    container_name   = "${var.project}-${var.env}-flask-service-container"
    container_port   = "5000"
  }
}