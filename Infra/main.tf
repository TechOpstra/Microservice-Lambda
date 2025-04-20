# Infra/main.tf

provider "aws" {
  region = var.region
}

# DynamoDB module
module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = var.dynamodb_table_name
  hash_key    = var.dynamodb_hash_key
  hash_key_type = var.dynamodb_hash_key_type
}

# IAM module
module "iam" {
  source   = "./modules/iam"
  role_name = var.iam_role_name
}

# Lambda module for both add and get users functions
module "lambda" {
  source                = "./modules/lambda"
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  lambda_zip_file       = var.lambda_zip_file
  dynamodb_table_name   = module.dynamodb.table_name
}

# API Gateway module
module "api_gateway" {
  source                = "./modules/api_gateway"
  api_name              = var.api_name
  api_description       = var.api_description
  get_users_lambda_arn  = module.lambda.get_users_lambda_arn
}

output "api_invoke_url" {
  value = module.api_gateway.api_invoke_url
}
