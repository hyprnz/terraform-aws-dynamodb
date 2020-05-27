data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "ApplicationAutoscalingAssumeRole"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "autoscaler" {
  statement {
    sid = "DynamoDBAutoscaler"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable",
    ]

    resources = ["${var.dynamodb_table_arn}"]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "autoscaler_cloudwatch" {
  statement {
    sid = "AutoscalerCloudWatch"

    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms",
    ]

    resources = ["*"]

    effect = "Allow"
  }
}

resource "aws_iam_role" "autoscaler" {
  count              = "${var.enabled ? 1 : 0}"
  name               = "${module.dynamodb_autoscaler_label.id}${var.delimiter}autoscaler"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
  tags               = "${module.dynamodb_autoscaler_label.tags}"
}

resource "aws_iam_role_policy" "autoscaler" {
  count  = "${var.enabled ? 1 : 0}"
  name   = "${module.dynamodb_autoscaler_label.id}${var.delimiter}autoscaler${var.delimiter}dynamodb"
  role   = "${join("", aws_iam_role.autoscaler.*.id)}"
  policy = "${data.aws_iam_policy_document.autoscaler.json}"
}

resource "aws_iam_role_policy" "autoscaler_cloudwatch" {
  count  = "${var.enabled ? 1 : 0}"
  name   = "${module.dynamodb_autoscaler_label.id}${var.delimiter}autoscaling${var.delimiter}cloudwatch"
  role   = "${join("", aws_iam_role.autoscaler.*.id)}"
  policy = "${data.aws_iam_policy_document.autoscaler_cloudwatch.json}"
}
