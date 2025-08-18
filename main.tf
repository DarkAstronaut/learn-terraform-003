resource "aws_instance" "my-existing-ec2" {
  # instance configuration
  ami           = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "FirstEC2Instance"
  }
}

# For Understanding Variables

resource "aws_s3_bucket" "tf-bucket" {
  bucket = var.bucket_name

  tags = var.tags
}