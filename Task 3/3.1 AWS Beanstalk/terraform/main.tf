terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "elasticbeanstalk/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  env        = terraform.workspace
  base_name  = "${var.project_name}-${local.env}"
  region     = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "elastic_beanstalk" {
  source                = "./modules/elastic_beanstalk"
  project_name          = var.project_name
  base_name             = local.base_name
  solution_stack_name   = var.solution_stack_name
  tier                  = var.tier
  instance_type         = var.instance_type
  minsize               = var.minsize
  maxsize               = var.maxsize
  certificate_arn       = var.certificate_arn
  elb_policy_name       = var.elb_policy_name
  elastic_beanstalk_env = var.elastic_beanstalk_env
  vpc_id                = data.aws_vpc.default.id
  subnet_ids            = data.aws_subnet_ids.default.ids
}
