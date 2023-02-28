module "ecs" {
  source = "../modules/ecs"
  aws_region = var.aws_region
  project = var.project
  env = var.env
  vpc_id = "vpc-09e6d92a607b8c8ad"
  subnets = ["subnet-08a56126c2044893d", "subnet-0c0befbdd344548af"]
  create_cluster = true
}
