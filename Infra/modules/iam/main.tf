resource "aws_iam_role" "lambda_execution_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

# Attach DynamoDB Full Access policy
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

# Attach DynamoDB Read-Only Access policy
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_readonly_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

# Attach Lambda Basic Execution policy for CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}


resource "aws_iam_role" "api_gateway_cloudwatch_logs" {
  name = "APIGatewayCloudWatchLogsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "api_gateway_logs_attachment" {
  name       = "APIGatewayCloudWatchLogsPolicyAttachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  roles      = [aws_iam_role.api_gateway_cloudwatch_logs.name]
}


output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}
