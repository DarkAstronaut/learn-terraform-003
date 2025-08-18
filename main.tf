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

# Use of Environment Variables

resource "aws_db_instance" "tf-sample-db" {
  identifier = "sample-db-identifier"
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  username = "admin"
  password = var.database_pw
  parameter_group_name = "default.mysql5.7"
}