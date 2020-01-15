# Queue-Fed Lambda Terraform Module

This module abstracts the newly-supported pattern of triggering a Lambda function directly from an SQS queue, and handles provisining the Lambda, queue, a dead-letter queue to hold failed messages, and a log group for the lambda.

## Quickstart

```terraform

module "q_lambda" {
  source "github.com/bmd/terraform-queue-fed-lambda"

  project_prefix = "qfl-test"

  filename      = "example.zip"
  function_name = "example_func_shun"
  handler       = "index.handle"

  runtime         = "go1.x"
  lambda_iam_role = aws_iam_role.test_iam.arn

  event_batch_size = 1
}

```

## Terraform Versions

Terraform 0.12 only

## Resources




## Variables

`filename` - the path to a deployable Lambda package on the filesystem where you are running `terraform apply`. For more information on creating a deployable Lambda package, look at [AWS's Documentation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html)

`function_name` - 


`dlq_message_retention_seconds` - 

`log_retention_in_days` - (Optional) The number of days to retain the Lambda's CloudWatch execution logs for. The default value is 14. If `0` is entered, a CloudWatch log stream will not be created (not recommended).

## Outputs