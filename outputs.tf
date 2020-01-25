output "task_queue_id" {
  description = "The URL of the task queue"
  value = aws_sqs_queue.task_queue.id
}

output "task_queue_arn" {
  description = "The ARN of the task queue"
  value       = aws_sqs_queue.task_queue.arn
}

output "deadletter_queue_id" {
  description = "The URL of the deadletter queue (if created)"
  value       = concat(aws_sqs_queue.deadletter_queue.*.id, [""])[0]
}

output "deadletter_queue_arn" {
  description = "The ARN of the deadletter queue (if created)"
  value       = concat(aws_sqs_queue.deadletter_queue.*.arn, [""])[0]
}

output "log_stream_arn" {
  value = concat(aws_cloudwatch_log_group.log_group.*.arn, [""])[0]
}
