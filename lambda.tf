######## Permissões para Lambda ########
# Cria a Role IAM para a Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-fast-food-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 🔹 Policy básica para logs no CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 🔹 Policy para acessar Secrets Manager
resource "aws_iam_role_policy" "lambda_secrets_policy" {
  name = "lambda-secrets-access"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]
        Resource = "*"
      }
    ]
  })
}

# 🔹 Policy para acessar o Cognito
resource "aws_iam_role_policy" "lambda_cognito_policy" {
  name = "lambda-cognito-access"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cognito-idp:AdminGetUser",
          "cognito-idp:ListUsers",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminRespondToAuthChallenge",
          "cognito-idp:AdminSetUserPassword",
          "cognito-idp:DescribeUserPool",
          "cognito-idp:ListUserPools",
          "cognito-idp:ListUserPoolClients"
        ]
        Resource = "*"
      }
    ]
  })
}

# Criação da Lambda
resource "aws_lambda_function" "fast_food_lambda" {
  function_name = "fast-food-lambda"
  role          = aws_iam_role.lambda_exec_role.arn
  # Role para conta AWS Academy
  # role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  runtime       = "nodejs18.x"
  handler       = "index.handler"
  filename      = "index.zip"
}