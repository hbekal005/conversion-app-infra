# Purpose: Create a DynamoDB table to store the lock state of the Terraform state file.
resource "aws_dynamodb_table" "backend_table" {
  name         = var.dynamodb_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}