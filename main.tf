resource "aws_lambda_function" "func" {
  function_name = var.function_name
  description   = var.description

  runtime  = var.runtime
  handler  = var.handler
  filename = var.filename
  publish  = var.publish
  role     = var.lambda_iam_role

  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "environment" {
    for_each = length(var.environment) < 1 ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }
}

resource "aws_sqs_queue" "task_queue" {
  name                      = "${var.project_prefix}-tasks"
  message_retention_seconds = var.message_retention_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = var.max_receive_count
  })
}

resource "aws_sqs_queue" "deadletter_queue" {
  name                      = "${var.project_prefix}-dlq"
  message_retention_seconds = var.dlq_message_retention_seconds
}

resource "aws_lambda_event_source_mapping" "queue_input_emitter" {
  event_source_arn = aws_sqs_queue.task_queue.arn
  function_name    = aws_lambda_function.func.arn
  batch_size       = var.event_batch_size
  enabled          = var.event_source_enabled
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.log_retention_in_days > 0 ? 1 : 0
  name              = "/aws/lambda/${aws_lambda_function.func.function_name}"
  retention_in_days = var.log_retention_in_days
}
