## VPC ##
output "aws_vpc-fast-food_id" {
  value = "${aws_vpc.vpc-fast-food.id}"
}

## Subnet ##
output "aws_subnet_fast-food-subnet-public2_id" {
  value = "${aws_subnet.fast-food-subnet-public2.id}"
}

output "aws_subnet_fast-food-subnet-private1_id" {
  value = "${aws_subnet.fast-food-subnet-private1.id}"
}

output "aws_subnet_fast-food-subnet-public1_id" {
  value = "${aws_subnet.fast-food-subnet-public1.id}"
}

output "aws_subnet_fast-food-subnet-private2_id" {
  value = "${aws_subnet.fast-food-subnet-private2.id}"
}


## Security Group ##
output "aws_security_group_sg-balancer-fast-food_id" {
  value = "${aws_security_group.sg-balancer-fast-food.id}"
}

output "aws_security_group_sg-cluster-fast-food_id" {
  value = "${aws_security_group.sg-cluster-fast-food.id}"
}


## DNS Name ##
output "alb_dns_name" {
  description = "DNS público do Network Load Balancer"
  value       = aws_lb.alb.dns_name
}

## VPC Link Id ##
# output "vpc_link_id" {
#   description = "ID do VPC Link usado no API Gateway"
#   value       = aws_api_gateway_vpc_link.vpc_link.id
# }

## DNS Name ##
output "api_gateway_id" {
  description = "ID da API Gateway gerada"
  value       = aws_api_gateway_rest_api.api-gtw.id
}

## URL ##
# output "api_gateway_invoke_url" {
#   description = "Endpoint base para invocar a API"
#   value       = "https://${aws_api_gateway_rest_api.api-gtw.id}.execute-api.${var.region}.amazonaws.com/prod"
# }


output "api_gateway_invoke_url" {
  description = "Endpoint base para invocar a API"
  value       = "https://${aws_api_gateway_rest_api.api-gtw.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.prod.stage_name}"
}