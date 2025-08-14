// Stores Terraform State file in S3 Bucket and lock with dynamodb

terraform {
  backend "s3" {
    bucket         = "tf-demo-s3-bucket-0544"                // Name of the Bucket
    key            = "terraform-state-dir/terraform.tfstate" // Folder where state file is stored
    region         = "us-east-2"
    profile        = "default"
    dynamodb_table = "tf-dynamo-table-1"
  }
}