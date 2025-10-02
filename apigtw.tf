# 📜 API Gateway REST API com OpenAPI gerado dinamicamente
resource "aws_api_gateway_rest_api" "api-gtw" {
  name = "fast-food-api-gtw"

  body = templatefile("${path.module}/openapi.yaml", {
    alb_dns       = aws_lb.alb.dns_name,
    region      = var.region,
    account_id  = var.account_id,
    # account_id  = data.aws_caller_identity.current.account_id,
    lambda_arn  = aws_lambda_function.fast_food_lambda.arn,
    userpool_id = aws_cognito_user_pool.cognito.id
    # vpc_link_id   = aws_api_gateway_vpc_link.vpc_link.id
  })
}


# Deployment da API
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api-gtw.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api-gtw.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Stage "prod"
resource "aws_api_gateway_stage" "prod" {
  rest_api_id   = aws_api_gateway_rest_api.api-gtw.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  stage_name    = "prod"
}

# Permissão para API Gateway invocar Lambda
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fast_food_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}