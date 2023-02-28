# Welcome

This repo is contains terraform files that creates the following resoources for deployment of a basic flask application

## Structure:

The files are separated into directories:
| Directory     | Description   |
| ------------- | ------------- |
| Dev           | This is used to deploy resources to the dev environment  |
| Prod          | This is used to deploy resources to the prod environment   |
| Module        | This is where the logic for creating the resources are stored. |
| FLask-hello-world-module | This idealy should be in a separate repo. |



## Resources Created

- module.ecs.aws_cloudwatch_log_group.log_groups_services
- module.ecs.aws_ecr_repository.repository
- module.ecs.aws_ecs_service.flask_service
- module.ecs.aws_ecs_task_definition.flask_task_def
- module.ecs.aws_lb.lb
- module.ecs.aws_lb_listener.http_listener
- module.ecs.aws_lb_target_group.flask
- module.ecs.aws_security_group.alb_sg
- module.ecs.aws_security_group.flask_sg
