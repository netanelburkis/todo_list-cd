terraform {
backend "s3" {
  bucket         = "my-terraform-state-bucket985789345"
  key            = "terraform/state"
  region         = "eu-central-1"
  dynamodb_table = "terraform_state_lock"
  encrypt        = true
}
}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "my-terraform-state-bucket985789345"
#
#  tags = {
#    Name        = "Terraform State Bucket"
#  }
#  lifecycle {
#    prevent_destroy = true
#  }
#}
#resource "aws_dynamodb_table" "terraform_state_lock" {
#  name           = "terraform_state_lock"
#  billing_mode   = "PAY_PER_REQUEST"
#  hash_key       = "LockID"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#
#  tags = {
#    Name = "Terraform State Lock Table"
#  }
#  lifecycle {
#    prevent_destroy = true
#  }
#}