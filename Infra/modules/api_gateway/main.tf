# modules/api_gateway/main.tf

resource "aws_api_gateway_rest_api" "serverless_rest_api" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "users_resource" {
  rest_api_id = aws_api_gateway_rest_api.serverless_rest_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_rest_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_method" "get_users_method" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_rest_api.id
  resource_id   = aws_api_gateway_resource.users_resource.id
  http_method   = "GET"
  authorization = "NONE"

  integration {
    type                   = "AWS_PROXY"
    integration_http_method = "POST"
    uri                     = var.get_users_lambda_arn
  }
}

resource "aws_api_gateway_deployment" "serverless_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.serverless_rest_api.id
  stage_name  = "v1"
}

resource "aws_lambda_permission" "allow_api_gateway_to_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_users_lambda_arn
  principal     = "apigateway.amazonaws.com"
}

output "api_invoke_url" {
  value = "${aws_api_gateway_rest_api.serverless_rest_api.endpoint}/v1/users"
}
