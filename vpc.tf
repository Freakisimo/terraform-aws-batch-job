resource "aws_vpc" "existing_vpc" {
  count = var.create_resources ? 1 : 0

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

data "aws_vpc" "existing_vpc" {
  count = var.create_resources ? 0 : 1

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }

  tags = {
    Tier = "Public"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.create_resources ? length(var.private_subnet_cidrs) : 0

  vpc_id            = aws_vpc.existing_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }
}

data "aws_subnets" "private_subnets" {
  count = var.create_resources ? 0 : length(var.private_subnet_cidrs)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }

  tags = {
    name   = "cidr-block"
    values = [element(var.private_subnet_cidrs, count.index)]
  }
}