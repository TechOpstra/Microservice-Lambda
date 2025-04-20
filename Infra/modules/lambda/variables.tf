# modules/lambda/variables.tf

variable "lambda_execution_role_arn" {
  description = "The ARN of the IAM role for Lambda execution"
  type        = string
}

variable "lambda_zip_file" {
  description = "The path to the Lambda function zip file"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The DynamoDB table name"
  type        = string
}
