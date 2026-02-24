module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  create_vpc = var.create_resources

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, max(length(var.public_subnet_cidrs), length(var.private_subnet_cidrs), 1))
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

data "aws_vpc" "existing_vpc" {
  count = var.create_resources ? 0 : 1

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public_subnets" {
  count = var.create_resources ? 0 : 1

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc[0].id]
  }

  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnets" "private_subnets" {
  count = var.create_resources ? 0 : 1

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc[0].id]
  }

  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}