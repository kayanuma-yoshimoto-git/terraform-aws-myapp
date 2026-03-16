resource "aws_s3_bucket" "artifact" {
  bucket = "myapp-artifact-kayanuma"

  tags = {
    Name        = "myapp-artifact-kayanuma"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "artifact" {
  bucket = aws_s3_bucket.artifact.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "artifact" {
  bucket = aws_s3_bucket.artifact.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}