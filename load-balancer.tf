# # 🔎 Buscar a VPC default do lab
# data "aws_vpc" "default" {
#   default = true
# }

# # 🔎 Buscar subnets existentes dentro da VPC
# data "aws_subnets" "default" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.default.id]
#   }
# }

# 🚀 Criar Network Load Balancer
# resource "aws_lb" "nlb" {
#   name               = "fast-food-nlb"
#   internal           = false
#   load_balancer_type = "network"
#   subnets            = [aws_subnet.fast-food-subnet-private1.id, aws_subnet.fast-food-subnet-public2.id]
#   # subnets            = [aws_subnet.fast-food-subnet-private1.id, aws_subnet.fast-food-subnet-private2.id, aws_subnet.fast-food-subnet-public1.id, aws_subnet.fast-food-subnet-public2.id]
# #   subnets            = data.aws_subnets.default.ids

#   tags = {
#     Name = "fast-food-fiap"
#   }
# }

# Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "fast-food-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-balancer-fast-food.id]
  subnets            = [aws_subnet.fast-food-subnet-public1.id, aws_subnet.fast-food-subnet-public2.id]

  tags = {
    Name = "fast-food-fiap-alb"
  }
}

# 🎯 Target Group para ECS/Kubernetes (instâncias EC2)
resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-fast-food-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc-fast-food.id
  target_type = "instance"

  tags = {
    Name = "fast-food-fiap"
  }
}

# 🎯 Target Group para Lambda
# resource "aws_lb_target_group" "lambda_tg" {
#   name        = "lambda-fast-food-target-group"
#   target_type = "lambda"
#   vpc_id      = aws_vpc.vpc-fast-food.id # exigido mesmo para Lambda

#   tags = {
#     Name = "fast-food-fiap"
#   }
# }

# Listener para encaminhar tráfego para o Target Group do ECS
resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  # protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

# Listener para encaminhar tráfego para o Target Group do Lambda
# resource "aws_lb_listener" "lambda_listener" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 81
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.lambda_tg.arn
#   }
# }
