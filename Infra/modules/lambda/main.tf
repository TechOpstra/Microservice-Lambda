# modules/lambda/main.tf

resource "aws_lambda_function" "add_sample_data" {
  function_name = "m1-add-sample-data"
  runtime       = "python3.10"
  role          = var.lambda_execution_role_arn
  handler       = "m1-add-sample-data.lambda_handler"

  filename      = var.lambda_zip_file

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
  handler       = "get-users.lambda_handler"

  filename      = var.lambda_zip_file

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
