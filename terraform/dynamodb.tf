resource "aws_dynamodb_table" "encrypted_data" {
  name         = "encrypted-data"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = "dev"
    Project     = "terraform-aws-myapp"
  }
}