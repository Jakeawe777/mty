variable "aws_region" {}
variable "project" {}
variable "env" {}
variable "vpc_id" {
}
variable "subnets" {
  type = list(string)
}

variable "create_cluster" {
  type = bool
  default = false
}