locals {
  vpc_id             = var.create_resources ? module.vpc.vpc_id : data.aws_vpc.existing_vpc[0].id
  security_group_id  = var.create_resources ? aws_security_group.main_sg[0].id : data.aws_security_group.main_sg[0].id
  private_subnet_ids = var.create_resources ? module.vpc.private_subnets : data.aws_subnets.private_subnets[0].ids
}