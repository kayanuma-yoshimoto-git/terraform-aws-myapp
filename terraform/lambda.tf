data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "../lambda/index.zip"
}

resource "aws_lambda_function" "hello" {

  function_name = "hello-${var.environment}"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  handler = "index.handler"

  runtime = "nodejs20.x"

  role = aws_iam_role.lambda_role.arn
}