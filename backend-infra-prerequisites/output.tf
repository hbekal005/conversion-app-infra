output "backend_s3_bucket" {
  value = aws_s3_bucket.backend_s3_bucket.id
}

output "backend_dynamodb_table" {
  value = aws_dynamodb_table.backend_table.name
}