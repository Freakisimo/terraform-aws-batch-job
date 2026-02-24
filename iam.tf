data "aws_caller_identity" "identity" {}

data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "batch.amazonaws.com",
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "execution_role" {
  count              = var.create_resources ? 1 : 0
  name               = "${var.model}-execution-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
  tags               = var.tags
}

data "aws_iam_role" "execution_role" {
  count = var.create_resources ? 0 : 1
  name  = "${var.model}-execution-role-${var.env}"
}

resource "aws_iam_role_policy" "execution_role_policy" {
  count = var.create_resources ? 1 : 0
  name  = "${var.model}-execution-role-policy-${var.env}"
  role  = aws_iam_role.execution_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:*",
          "logs:*",
          "s3:*"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "batch_job_role" {
  count              = var.create_resources ? 1 : 0
  name               = "${var.model}-batch-job-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
  tags               = var.tags
}

data "aws_iam_role" "batch_job_role" {
  count = var.create_resources ? 0 : 1
  name  = "${var.model}-batch-job-role-${var.env}"
}

resource "aws_iam_role_policy" "batch_job_role_policy" {
  count = var.create_resources ? 1 : 0
  name  = "${var.model}-batch-job-role-policy-${var.env}"
  role  = aws_iam_role.batch_job_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "ecr:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:*"
        Resource = "*"
      }
    ],
  })
}