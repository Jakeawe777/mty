output "lb_dns_name" {
  value = aws_lb.lb.dns_name
}

output "ecr_repo_url" {
  value = aws_ecr_repository.repository.repository_url
}