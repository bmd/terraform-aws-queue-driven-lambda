# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED INPUTS
# ---------------------------------------------------------------------------------------------------------------------

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. For more information on creating a deployable Lambda package, look at [AWS's Documentation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html)"
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
  description = "IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See [Lambda Permission Model](https://docs.aws.amazon.com/lambda/latest/dg/lambda-permissions.html) for more details"
  type        = string
}

variable "project_prefix" {
  description = "A prefix to apply to resources created by this module"
  type        = string
}

variable "runtime" {
  description = "See [runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) for valid values."
  type        = string
}

# ----------------------------------------
# OPTIONAL INPUTS
# ----------------------------------------

# -- Lambda --
variable "description" {
  description = "Description of what your Lambda Function does. "
  type        = string
  default     = ""
}

variable "environment" {
  description = "The Lambda environment's configuration settings. See [the official module's documentation](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#environment) for valid values."
  type        = map(map(string))
  default     = {}
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  type        = number
  default     = 128
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  type        = bool
  default     = false
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1"
  type        = string
  default     = "-1"
}

variable "timeout" {
  description = " The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  type        = number
  default     = 3
}

# -- Event --
variable "event_source_enabled" {
  description = "Whether the event mapping between the SQS Queue and Lambda should be enabled on creation. If set to false, messages sent to the SQS queue will not trigger the Lambda function. Defaults to true"
  type        = bool
  default     = true
}

variable "event_batch_size" {
  description = "The largest number of records that Lambda will retrieve from the SQS queue at the time of invocation. Default is 10"
  type        = number
  default     = 10
}

# -- Queues --
variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)"
  type        = number
  default     = 345600
}

variable "dlq_message_retention_seconds" {
  description = "The message retention settings for the Deadletter Queue. See the description for `message_retention_seconds` for default values and limits"
  type        = number
  default     = 345600
}

variable "max_receive_count" {
  description = "The number of times a message should be replayed before it's sent to the deadletter queue"
  type        = number
  default     = 5
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)"
  type    = number
  default = 262144
}

# -- Logging --
variable "log_retention_in_days" {
  description = "The number of days to retain the Lambda's CloudWatch execution logs for. The default value is 14. If `0` is entered, a CloudWatch log stream will not be created (not recommended)."
  type        = number
  default     = 14
}
