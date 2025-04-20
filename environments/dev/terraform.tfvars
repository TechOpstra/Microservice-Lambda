region = "us-east-1" 
add_user_zip_file = "../Infra/add_user.zip"
get_user_zip_file = "../Infra/get_user.zip"

dynamodb_table_name       = "serverless_workshop_intro"
dynamodb_hash_key         = "_id"
dynamodb_hash_key_type    = "S"

iam_role_name = "lambda_execution_role"

api_name        = "ServerlessREST"
api_description = "API for accessing DynamoDB items"
