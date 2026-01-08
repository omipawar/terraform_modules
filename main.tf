module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr_block        = "192.168.0.0/16"
  pub_subnet_cidr_block = "192.168.0.0/20"
  subnet_az             = "ap-south-1a"
  allow_all             = "0.0.0.0/0"
}

module "ec2" {
  source                = "./modules/ec2"
  amazon_linux_ami      = "ami-0ced6a024bb18ff2e"
  ec2_keypair           = "secondKey"
  instance_type         = "t3.micro"
  vpc_security_group_id = module.vpc.vpc_security_group_id
  subnet_id             = module.vpc.subnet_id
}
