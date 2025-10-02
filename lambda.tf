resource "aws_lambda_function" "fast_food_lambda" {
  function_name = "fast-food-lambda"
  role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  # role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  runtime       = "nodejs18.x"
  handler       = "index.handler"
  filename      = "index.zip"
}