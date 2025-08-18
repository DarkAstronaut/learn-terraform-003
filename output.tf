output "bucket_name_output" {
  description = "Name of the S3 Bucket created"
  value       = aws_s3_bucket.tf-bucket.bucket # To get Bucket Name
}
