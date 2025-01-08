# Purpose: Create an S3 bucket to store Terraform state files.
resource "aws_s3_bucket" "backend_s3_bucket" {
  bucket = var.terraform_s3_bucket

  depends_on = [aws_dynamodb_table.backend_table]
}

resource "aws_s3_bucket_versioning" "backend_s3_bucket_versioning" {
  bucket = aws_s3_bucket.backend_s3_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_s3_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.backend_s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}