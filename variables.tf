# data "terraform_remote_state" "vpc" {
#   backend = "local"

#   config = {
#     path = "../../../generated/aws/vpc/terraform.tfstate"
#   }
# }

variable "vpc_id" {
  default = "vpc-05b49e5e880da8cd4"
}

variable "region" {
  description = "Região da AWS Norte da Virginia"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "Id conta aws"
  type        = string
  default     = "891377152273"
}