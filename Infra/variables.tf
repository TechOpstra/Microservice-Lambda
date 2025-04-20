# Infra/variables.tf

variable "region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_zip_file" {
  description = "Path to the Lambda function zip file"
  type        = string
}
