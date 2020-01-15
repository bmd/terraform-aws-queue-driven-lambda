# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED INPUTS
# ---------------------------------------------------------------------------------------------------------------------

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem."
  type        = string
}

variable "function_name" {
  description = "A unique name for your Lambda Function."
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = string
}

variable "lambda_iam_role" {
  type = string
}

variable "project_prefix" {
  description = "A prefix to apply to resources created by this module"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function you are uploading."
  type        = string
}

# ----------------------------------------
# OPTIONAL INPUTS
# ----------------------------------------

# -- Lambda --
variable "description" {
  type    = string
  default = ""
}

variable "environment" {
  description = "Environment (e.g. env variables) configuration for the Lambda function enable you to dynamically pass settings to your function code and libraries"
  type        = map(map(string))
  default     = {}
}

variable "logfilter_destination_arn" {
  description = "The ARN of the destination to deliver matching log events to. Kinesis stream or Lambda function ARN."
  default     = ""
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  default     = 128
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to true."
  default     = true
}

variable "reserved_concurrent_executions" {
  type    = string
  default = "-1"
}

variable "timeout" {
  type    = number
  default = 3
}

# -- Event --
variable "event_source_enabled" {
  type    = bool
  default = true
}

variable "event_batch_size" {
  type    = number
  default = 10
}

# -- Queues --
variable "message_retention_seconds" {
  type    = number
  default = 345600 # 4 Days
}

variable "max_receive_count" {
  type    = number
  default = 5
}

variable "maximum_message_size" {
  type    = number
  default = 262144
}

variable "dlq_message_retention_seconds" {
  type    = number
  default = 345600 # 4 Days
}

# -- Logging --
variable "log_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Defaults to 14."
  type        = number
  default     = 14
}
