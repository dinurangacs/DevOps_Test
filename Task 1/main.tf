


module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}


module "ec2" {
  source = "./modules/ec2"

  ami_id = "" # 
  instance_type = "t2.micro"
  key_name = "my-ec2-key"
  vpc_id   = module.vpc.vpc_id 
  allowed_ssh_cidr = "0.0.0.0/0"
  subnet_id = module.vpc.public_subnet_ids[0] 

}

# Call the RDS Module

module "rds" {
  source = "./modules/rds"
  db_name = "mydb"
  username = "admin"
  password = data.aws_ssm_parameter.rds_password.value  

  subnet_ids = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.rds_sg_id]
}