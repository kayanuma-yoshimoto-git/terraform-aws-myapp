resource "aws_apigatewayv2_api" "api" {

  name = "hello-api-${var.environment}"

  protocol_type = "HTTP"
}