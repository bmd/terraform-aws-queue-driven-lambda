# Queue-Fed Lambda Terraform Module

This module abstracts the newly-supported pattern of triggering a Lambda function directly from an SQS queue, and handles provisining the Lambda, queue, a dead-letter queue to hold failed messages, and a log group for the lambda.

You can read more about the architectural and design principles in [AWS's introduction to the pattern](https://aws.amazon.com/serverless/use-sqs-as-an-event-source-for-lambda-tutorial/).

## Quickstart

```terraform

module "q_lambda" {
  source "bmd/queue-driven-lambda/aws"

  project_prefix = "qfl-test"

  filename      = "example.zip"
  function_name = "my_lambda_fn"
  handler       = "index.handle"

  runtime         = "go1.x"
  lambda_iam_role = aws_iam_role.test_iam.arn

  event_batch_size = 1
}

```

## Supported Terraform Versions

* Terraform 0.12

### Note on IAM permissions.

In order to create a Lambda function with an SQS queue as an event source, you will need to ensure that the Lambda function's IAM role allows it to perform the appropriate actions on SQS resources. See the IAM policy in `examples/example.tf` for the minimal set of permissions that the function requires.