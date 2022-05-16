resource "aws_api_gateway_rest_api" "Fxlink-Api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.aws_api_gateway_rest_api_title
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = var.api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "Fxlink-Api_deploy" {
  rest_api_id = aws_api_gateway_rest_api.Fxlink-Api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.Fxlink-Api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "Fxlink_Stage" {
  deployment_id = aws_api_gateway_deployment.Fxlink-Api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.Fxlink-Api.id
  stage_name    = "f1"
}