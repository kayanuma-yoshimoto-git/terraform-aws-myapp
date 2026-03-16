resource "aws_kms_key" "dynamodb" { 
  description         = "KMS key for ${var.environment} DynamoDB"
  enable_key_rotation = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      {
        Sid = "EnableRootPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::925785106635:root"
        }
        Action = "kms:*"
        Resource = "*"
      },

      {
        Sid = "AllowLambdaUseKey"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.lambda_role.arn
        }
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }

    ]
  })
}

resource "aws_kms_alias" "dynamodb_alias" {
  name          = "alias/myapp-${var.environment}-dynamodb"
  target_key_id = aws_kms_key.dynamodb.key_id
}