resource "aws_batch_compute_environment" "batch_ce" {
  name = "${var.model}-compute-environment-${var.env}"
  type = "MANAGED"
  compute_resources {
    type               = "FARGATE"
    min_vcpus          = var.min_vcpu
    max_vcpus          = var.max_vcpu
    security_group_ids = [local.security_group_id]
    subnets            = local.private_subnet_ids
  }
  tags = var.tags
}

resource "aws_batch_job_queue" "batch_ce" {
  name                 = "${var.model}-job-queue-${var.env}"
  priority             = 1
  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.batch_ce.arn
  }
  state                = "ENABLED"
  tags                 = var.tags
}

resource "aws_batch_job_definition" "batch_ce" {
  name = "${var.model}-job-definition-${var.env}"
  type = "container"
  platform_capabilities = [
    "FARGATE",
  ]
  tags = var.tags

  container_properties = <<EOF
    {
      "image": "${var.image}",
      "fargatePlatformConfiguration": { "platformVersion": "1.4.0" },
      "resourceRequirements": [
        {"type": "MEMORY", "value": "${var.memory}"},
        {"type": "VCPU",   "value": "${var.vcpu}"}
      ],
      "executionRoleArn": "${var.create_resources ? aws_iam_role.execution_role[0].arn : data.aws_iam_role.execution_role[0].arn}",
      "jobRoleArn": "${var.create_resources ? aws_iam_role.batch_job_role[0].arn : data.aws_iam_role.batch_job_role[0].arn}"
    }
    EOF
}


# "executionRoleArn": "${aws_iam_role.execution_role.arn}",
# "jobRoleArn": "${aws_iam_role.batch_job_role.arn}"