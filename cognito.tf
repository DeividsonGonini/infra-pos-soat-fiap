
# -----------------------------
# Cognito User Pool
# -----------------------------
resource "aws_cognito_user_pool" "cognito" {
  name = "backend-app-user-pool"

  schema {
    name                = "cpf"
    attribute_data_type = "String"
    required            = false   # custom attributes não podem ser required
    mutable             = false
    string_attribute_constraints {
      min_length = 11
      max_length = 14
    }
  }
}

# -----------------------------
# User Pool Client
# -----------------------------
resource "aws_cognito_user_pool_client" "client" {
  name         = "backend-app-client"
  user_pool_id = aws_cognito_user_pool.cognito.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH"]
}