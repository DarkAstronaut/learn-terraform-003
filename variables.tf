variable "bucket_name" {
  description = "Name for the S3 Bucket"
  type        = string
  default     = "tf-demo-bucket-17082025"
}

variable "tags" {
  description = "A Map of Tags for the S3 Bucket"
  type        = map(string)
  default = {
    Name        = "tf-course-demo-101"
    Environment = "Development"
  }
}