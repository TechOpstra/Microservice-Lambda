# modules/dynamodb/main.tf

resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = var.table_name
  hash_key       = var.hash_key
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = "Userid"
    type = "S"
  }

  attribute {
    name = "FullName"
    type = "S"
  }
}

output "table_name" {
  value = aws_dynamodb_table.serverless_workshop_intro.name
}
