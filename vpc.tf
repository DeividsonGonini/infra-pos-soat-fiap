# resource "aws_vpc" "tfer--vpc-002D-0ce0055913e6f45c4" {
resource "aws_vpc" "vpc-fast-food" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "10.0.0.0/16"
  # cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"
  # ipv6_netmask_length                  = "0"

  tags = {
    Name    = "fast-food-vpc"
    project = "fiap-fast-food"
  }

  tags_all = {
    Name    = "fast-food-vpc"
    project = "fiap-fast-food"
  }
}


# resource "aws_api_gateway_vpc_link" "vpc_link" {
#   name        = "fast-food-vpc-link"
#   target_arns = [aws_lb.alb.arn]

#   tags = {
#     Name = "fast-food-fiap"
#   }
# }


# resource "aws_vpc" "tfer--vpc-002D-0f8ad6b0fec2429aa" {
#   assign_generated_ipv6_cidr_block     = "false"
#   cidr_block                           = "172.31.0.0/16"
#   enable_dns_hostnames                 = "true"
#   enable_dns_support                   = "true"
#   enable_network_address_usage_metrics = "false"
#   instance_tenancy                     = "default"
#   ipv6_netmask_length                  = "0"
# }
