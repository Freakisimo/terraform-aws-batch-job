data "aws_caller_identity" "identity" {}

data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com", 
        "batch.amazonaws.com"
        ]
    }
  }
}

resource "aws_iam_role" "execution_role" {
  name               = "${var.model}-execution-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "execution_role_policy" {
  name = "${var.model}-execution-role-policy-${var.env}"
  role = aws_iam_role.execution_role.id

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
  name               = "${var.model}-batch-job-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "batch_job_role_policy" {
  name = "${var.model}-batch-job-role-policy-${var.env}"
  role = aws_iam_role.batch_job_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = "ecr:*"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = "logs:*"
        Resource = "*"
      }
    ],
  })
}