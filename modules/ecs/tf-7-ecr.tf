resource "aws_ecr_repository" "repository" {
  #count  = var.create_ecr ? 1 : 0
  name                 = "${var.project}-${var.env}-flask-hello-world-ecr"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    prevent_destroy = false
  }
}

#data "aws_ecr_repository" "service" {
#  name = "ecr-repository"
#}