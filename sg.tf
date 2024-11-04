data "aws_security_group" "main_sg" {
  vpc_id = data.aws_vpc.existing_vpc.id

  filter {
    name   = "group-name"
    values = ["${var.main_sg}"]
  }
}