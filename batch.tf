resource "aws_batch_compute_environment" "batch_ce" {
  compute_environment_name = "${var.model}-compute-environment-${var.env}"
  type                     = "MANAGED"
  compute_resources {
    type = "FARGATE"
    min_vcpus = "${var.min_vcpu}"
    max_vcpus = "${var.max_vcpu}"
    # security_group_ids = [data.aws_security_group.main_sg.id]
    # subnets = local.private_subnet
    security_group_ids = [var.create_resources ? aws_security_group.main_sg.id : data.aws_security_group.main_sg.id]
    subnets = var.create_resources ? aws_subnet.private_subnet[*].id : data.aws_subnet.private_subnet[*].id
  }
}

resource "aws_batch_job_queue" "batch_ce" {
  name                  = "${var.model}-job-queue-${var.env}"
  priority              = 1
  compute_environments  = [aws_batch_compute_environment.batch_ce.id]
  state                 = "ENABLED"
}

resource "aws_batch_job_definition" "batch_ce" {
  name                  = "${var.model}-job-definition-${var.env}"
  type                  = "container"
  platform_capabilities = [
    "FARGATE",
  ]

  container_properties  = <<EOF
    {
      "image": "${var.image}",
      "fargatePlatformConfiguration": { "platformVersion": "1.4.0" },
      "resourceRequirements": [
        {"type": "MEMORY", "value": "${var.memory}"},
        {"type": "VCPU",   "value": "${var.vcpu}"}
      ],
      "executionRoleArn": "${var.create_resources ? aws_iam_role.execution_role.arn : data.aws_iam_role.execution_role.arn}",
      "jobRoleArn": "${var.create_resources ? aws_iam_role.batch_job_role.arn : data.aws_iam_role.batch_job_role.arn}"
    }
    EOF
}


# "executionRoleArn": "${aws_iam_role.execution_role.arn}",
# "jobRoleArn": "${aws_iam_role.batch_job_role.arn}"