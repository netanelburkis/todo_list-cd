// First, we create an S3 bucket and a DynamoDB table for Terraform state management.
// The S3 bucket stores the Terraform state file,
// while the DynamoDB table manages state locking to prevent conflicts when multiple users modify the infrastructure simultaneously.

// After creating these resources, we configure them in the Terraform backend block.
// This setup ensures safe and collaborative Terraform usage by storing state remotely and enabling locking.

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-todo-list-cd-by-nb" // Name of the S3 bucket     
    key            = "todo-list-cd/terraform.tfstate"               // Path inside the bucket to store the state file
    region         = "eu-central-1"                                 // AWS region
    encrypt        = true                                           // Encrypt the state file at rest
    dynamodb_table = "todo-list-cd-terraform-state-lock"            // DynamoDB table for state locking
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-todo-list-cd-by-nb"

  tags = {
    Name        = "todo-list-cd-terraform-state"
  }
  lifecycle {
    prevent_destroy = true // Prevent accidental deletion of the bucket
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "todo-list-cd-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "todo-list-cd-terraform-state-lock"
  }
  lifecycle {
    prevent_destroy = true // Prevent accidental deletion of the table
  }
}