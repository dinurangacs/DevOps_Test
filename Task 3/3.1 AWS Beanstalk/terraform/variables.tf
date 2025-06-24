variable "project_name" {
  type = string
}

variable "solution_stack_name" {
  type = string
}

variable "tier" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "minsize" {
  type    = number
  default = 1
}

variable "maxsize" {
  type    = number
  default = 2
}

variable "certificate_arn" {
  type = string
}

variable "elb_policy_name" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "elastic_beanstalk_env" {
  type = map(string)
}
