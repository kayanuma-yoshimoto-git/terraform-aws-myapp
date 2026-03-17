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

resource "aws_iam_policy" "s3_artifact_policy" {

  name = "ec2-artifact-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetObject"]
        Resource = "arn:aws:s3:::myapp-artifact-kayanuma/*"
      }
    ]
  })

}