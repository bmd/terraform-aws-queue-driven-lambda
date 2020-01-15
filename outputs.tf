output "task_queue_id" {
  value = aws_sqs_queue.task_queue.id
}

output "task_queue_arn" {
  value = aws_sqs_queue.task_queue.arn
}

output "deadletter_queue_id" {
  value = concat(aws_sqs_queue.deadletter_queue.*.id, [""])[0]
}

output "deadletter_queue_arn" {
  value = concat(aws_sqs_queue.deadletter_queue.*.arn, [""])[0]
}

output "log_stream_arn" {
  value = concat(aws_cloudwatch_log_group.log_group.*.arn, [""])[0]
}
