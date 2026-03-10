resource "aws_lambda_function" "hello" {

  function_name = "hello-${var.environment}"

  filename = data.archive_file.lambda_zip.output_path

  handler = "index.handler"

  runtime = "nodejs20.x"

  role = aws_iam_role.lambda_role.arn
}