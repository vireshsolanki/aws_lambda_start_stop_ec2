module "vpc" {
    source = "../modules/vpc"
    region = var.region
    cidr-block = var.cidr-block
    name = var.name
    public-subnet-1a = var.public-subnet-1a
    public-subnet-1b = var.public-subnet-1b
    private-subnet-1a = var.private-subnet-1a
    private-subnet-1b = var.private-subnet-1b
}
module "ec2" {
    source = "../modules/ec2"
    vpc-id = module.vpc.vpc-id
    public-subnet-1a-id = module.vpc.public-subnet-1a-id
    public-subnet-1b-id = module.vpc.public-subnet-1b-id
    private-subnet-1a-id = module.vpc.private-subnet-1a-id
    private-subnet-1b-id = module.vpc.private-subnet-1b-id
    name = var.name
    instance-type = var.instance-type
    file-name = var.file-name 
}
module "policy" {
    source = "../modules/iam-policy"
    name = var.name
  
}
module "iam-role" {
    source = "../modules/iam-role"
    name = var.name
    policy-arn = module.policy.policy-arn
}
module "lambda" {
    source = "../modules/lambda"
    role-arn = module.iam-role.role-arn
    instance-id = module.ec2.instance-id
    
  
}
  