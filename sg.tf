data "aws_availability_zones" "available" {}

resource "aws_security_group" "main_sg" {
  count = var.create_resources ? 1 : 0

  name   = var.main_sg
  vpc_id = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "main_sg" {
  count = var.create_resources ? 0 : 1

  vpc_id = data.aws_vpc.existing_vpc.id

  filter {
    name   = "group-name"
    values = ["${var.main_sg}"]
  }
}