variable "project_name" {}
variable "base_name" {}
variable "solution_stack_name" {}
variable "tier" {}
variable "instance_type" {}
variable "minsize" {}
variable "maxsize" {}
variable "certificate_arn" {}
variable "elb_policy_name" {}
variable "elastic_beanstalk_env" {
  type = map(string)
}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
