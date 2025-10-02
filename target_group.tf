# resource "aws_lb_target_group" "nlb_target_group" {
#   name_prefix = "nlb-fast-food-tg" # Prefixo do nome do grupo de destino
#   port        = 80              # Porta para onde o tráfego será encaminhado
#   protocol    = "TCP"           # Protocolo (TCP para NLB)
#   vpc_id = aws_vpc.vpc-fast-food.id #pega o id da VPC que iremos criar
 
#   # Para Target Groups de NLB, o 'target_type' é 'instance' ou 'ip' por padrão.
#   # Se você quiser usar IP target groups, adicione: target_type = "ip"
#   # No caso de instâncias EC2, o target_type é 'instance' (padrão)
#   target_type = "instance"


#   tags = {
#     Name    = "balancers-fast-food-security-group"
#     project = "fiap-fast-food"
#   }
# }
