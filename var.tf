variable "region" {
  default = "ca-central-1"
}
variable "main_vpc_cidr" {}
variable "public_subnet1" {}
variable "public_subnet2" {}
variable "private_subnet1" {}
variable "private_subnet2" {}
variable "private_subnet3" {}
# variable "Environment" {}
variable "bucket_name"{
  default = "fxlinkdefault"
  type = string
  description = "s3_bucket"
}

#SQS
variable "sqs_name"{
  default = "sqs_name"
  type = string
  description = "sqs_name"
}

variable "visibility_timeout_seconds"{
  description = "visibility_timeout_seconds"
  type        = number
  default     = "30"
}

# variable "message_retention_seconds"{
#   description = "message_retention_seconds"
#   type        = number
#   default     = "86400"
# }

variable "max_message_size"{
  description = "max_message_size"
  type        = number
  default     = "262144"
}

variable "receive_wait_time_seconds"{
  description = "receive_wait_time_seconds"
  type        = number
  default     = "10"
}
# variable "delay_seconds"{
#   description = "delay_seconds"
#   type        = number
#   default     = "10"
# }

variable "aws_security_group_SQS"{
  description = "aws_security_group_SQS"
  type        = string
  default     = "Fxlink-SQS-security_group"
}

variable "aws_api_gateway_rest_api_title"{
  description = "aws_security_group_SQS"
  type        = string
  default     = "Fxlink-2.0-api_gateway"
}

variable "api_name"{
  description = "aws_security_group_SQS"
  type        = string
  default     = "Fxlink-2.0-api"
}

variable "create" {
  description = "Whether to create SQS queue"
  type        = bool
  default     = true
}

variable "name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "A unique name beginning with the specified prefix."
  type        = string
  default     = null
}

variable "policy" {
  description = "The JSON policy for the SQS queue"
  type        = string
  default     = ""
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string (\"5\")"
  type        = string
  default     = ""
}

variable "redrive_allow_policy" {
  description = "The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs."
  type        = string
  default     = ""
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
  type        = number
  default     = 300
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}