resource "aws_lambda_function" "payment" {

  function_name = "payment-${var.environment}"

  filename = "../lambda/index.zip"
  handler  = "index.handler"
  runtime  = "nodejs18.x"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.payments.name
    }
  }
}