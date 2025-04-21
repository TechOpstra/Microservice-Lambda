# modules/lambda/main.tf

resource "aws_lambda_function" "add_sample_data" {
  function_name = "m1-add-sample-data"
  runtime       = "python3.10"
  role          = var.lambda_execution_role_arn
  handler       = "add_user.lambda_handler"

  filename      = var.add_user_zip_file

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

resource "aws_lambda_function" "get_users" {
  function_name = "get-users"
  runtime       = "python3.10"
  role          = var.lambda_execution_role_arn
  handler       = "get_user.lambda_handler"

  filename      = var.get_user_zip_file

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

output "add_sample_data_lambda_arn" {
  value = aws_lambda_function.add_sample_data.arn
}

output "get_users_lambda_arn" {
  value = aws_lambda_function.get_users.arn
}
