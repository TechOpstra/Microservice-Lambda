# Infra/main.tf

provider "aws" {
  region = "us-east-1"
}

# DynamoDB module
module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = "serverless_workshop_intro"
  hash_key    = "_id"
  hash_key_type = "S"
}

# IAM module
module "iam" {
  source   = "./modules/iam"
  role_name = "lambda_execution_role"
}

# Lambda module for both add and get users functions
module "lambda" {
  source                = "./modules/lambda"
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  lambda_zip_file       = "path_to_your_lambda_zips/m1-add-sample-data.zip"
  dynamodb_table_name   = module.dynamodb.table_name
}

# API Gateway module
module "api_gateway" {
  source                = "./modules/api_gateway"
  api_name              = "ServerlessREST"
  api_description       = "API for accessing DynamoDB items"
  get_users_lambda_arn  = module.lambda.get_users_lambda_arn
}

output "api_invoke_url" {
  value = module.api_gateway.api_invoke_url
}
