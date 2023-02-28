output "lb_dns_name" {
  value = module.ecs.lb_dns_name
}

output "ecr_uri" {
  value = module.ecs.ecr_repo_url
}