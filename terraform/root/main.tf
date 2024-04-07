module "vpc" {
  source          = "../modules/vpc"
  project_name    = var.project_name
  region          = var.aws_region
  vpc_cidr        = var.vpc_cidr
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2b_cidr = var.pub_sub_2b_cidr

}
module "key" {
  source = "../modules/key" 
  
}
module "Jenkins" {
  source = "../modules/jenkins"
  ami    = var.ami
  type   = var.type
  KEY_NAME = module.key.KEY_NAME
  subnet_id = module.vpc.pub_sub_1a_id
  vpc_id = module.vpc.vpc_id
}
module "K8S-EC2" {
  source = "../modules/K8S-EC2"
  ami = var.ami
   type = var.type
  KEY_NAME = module.key.KEY_NAME
  subnet_id = module.vpc.pub_sub_2b_id
  instance_count = var.instance_count
  vpc_id = module.vpc.vpc_id
}
