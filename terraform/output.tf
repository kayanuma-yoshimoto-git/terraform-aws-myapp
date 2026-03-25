output "api_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "frontend_url" {

  value = "http://${aws_instance.frontend.public_ip}"

}