provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "test_iam" {
  name = "tf-lambda-test-iam"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_iam_attachment" {
  role       = aws_iam_role.test_iam.name
  policy_arn = aws_iam_policy.lambda_iam_policy.arn
}

resource "aws_iam_policy" "lambda_iam_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ListQueues"
        ]
        Resource = "*"
      }
    ]
  })
}

module "queue_fed_lambda" {
  source = "../"

  project_prefix = "qfl-test"

  filename      = "example.zip"
  function_name = "example_func_shun"
  handler       = "index.handle"

  runtime         = "go1.x"
  lambda_iam_role = aws_iam_role.test_iam.arn

  event_batch_size = 1
}
