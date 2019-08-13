locals {
  common_tags = {
    environment = var.environment_name
    owner       = var.owner_name
    ttl         = var.ttl
  }
}

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "main" {
  name               = "${var.environment_name}-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.main.json
  tags               = merge(local.common_tags, var.tags == null ? {} : var.tags, { Name = var.name })
}

resource "aws_iam_policy" "main" {
  name   = "${var.environment_name}-${var.name}"
  policy = var.policy
}

resource "aws_iam_policy_attachment" "main" {
  name       = "${var.environment_name}-${var.name}"
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.environment_name}-${var.name}"
  role = aws_iam_role.main.name
}
