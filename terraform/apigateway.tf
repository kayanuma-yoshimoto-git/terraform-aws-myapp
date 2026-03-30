resource "aws_apigatewayv2_api" "api" {
  name          = "payment-api-${var.environment}"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]  # 本番環境では特定のドメインに絞る
    allow_methods = ["GET", "OPTIONS"]
    allow_headers = ["Content-Type"]
    max_age       = 300
  }
}

resource "aws_apigatewayv2_integration" "lambda" {

  api_id = aws_apigatewayv2_api.api.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.payment.invoke_arn

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "payment" {

  api_id = aws_apigatewayv2_api.api.id

  route_key = "GET /payment"

  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {

  api_id = aws_apigatewayv2_api.api.id

  name = "$default"

  auto_deploy = true
}

resource "aws_lambda_permission" "api" {

  statement_id = "AllowAPIGatewayInvoke"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.payment.function_name

  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}