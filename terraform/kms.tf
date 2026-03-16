resource "aws_kms_key" "dynamodb" {
  description         = "KMS key for ${var.environment} DynamoDB"
  enable_key_rotation = true
}

resource "aws_kms_alias" "dynamodb_alias" {
  name          = "alias/myapp-${var.environment}-dynamodb"
  target_key_id = aws_kms_key.dynamodb.key_id
}