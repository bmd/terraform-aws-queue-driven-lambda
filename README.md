# Queue-Fed Lambda Terraform Module

This module abstracts the newly-supported pattern of triggering a Lambda function directly from an SQS queue, and handles provisioning the Lambda, queue, a dead-letter queue to hold failed messages, and a Cloudwatch log group for the Lambda's invocation and function logs.

The high level architecture of this module is easy to visualize: 

![Architecture](https://raw.githubusercontent.com/bmd/terraform-aws-queue-driven-lambda/master/assets/architecture.png)

You can read more about the design principles in and use-cases [AWS's introduction to the pattern](https://aws.amazon.com/serverless/use-sqs-as-an-event-source-for-lambda-tutorial/).

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

A complete example of the minimal code required to get this working is found in `examples/simple`.

## Supported Terraform Versions

* Terraform 0.12

## Notes on IAM permissions.

#### SQS
In order to create a Lambda function with an SQS queue as an event source, you will need to ensure that the Lambda function's IAM role allows it to perform the appropriate actions on SQS resources. See the IAM policy in `examples/simple/example.tf` for the minimal set of permissions that the function requires.
