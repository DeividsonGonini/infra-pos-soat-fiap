# resource "aws_security_group" "tfer--balancers-002D-fast-002D-food-002D-security-002D-group_sg-002D-033282b0b0f5bd06f" {
resource "aws_security_group" "sg-balancer-fast-food" {
  description = "Security group do load balancer"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tudo o que vai chegar no Security Group"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    # self        = "false"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Podera sair pela sua origem, como entrou pela 80 sai pela 80"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    # self        = "false"
  }

  name = "balancers-fast-food-security-group"

  tags = {
    Name    = "balancers-fast-food-security-group"
    project = "fiap-fast-food"
  }

  tags_all = {
    Name    = "balancers-fast-food-security-group"
    project = "fiap-fast-food"
  }

  vpc_id = aws_vpc.vpc-fast-food.id #pega o id da VPC que iremos criar
}

# resource "aws_security_group" "tfer--cluster-002D-fast-002D-food-002D-security-002D-group_sg-002D-0a3df042bc5e9e651" {
resource "aws_security_group" "sg-cluster-fast-food" {
  description = "SG utilizado nos clusters"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Podera sair pela sua origem"
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    description     = "So permitiremos a entrada caso a origem seja do balancers security group"
    from_port       = "3000"
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-balancer-fast-food.id]
    self            = "false"
    to_port         = "3000"
  }

  name = "cluster-fast-food-security-group"

  tags = {
    Name    = "cluster-fast-food-security-group"
    project = "fiap-fast-food"
  }

  tags_all = {
    Name    = "cluster-fast-food-security-group"
    project = "fiap-fast-food"
  }

  vpc_id = aws_vpc.vpc-fast-food.id #pega o id da VPC que iremos criar
}