variable "dashboard_name" {
  default = "dash1"
  }

variable "ecs_cluster_name" {}
variable "ecs_service_name" {}
variable "alb_name" {}
variable "target_group_name" {}
variable "rds_instance_name" {}

variable "region" {
  default = "us-east-1"
  }
