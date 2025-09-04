resource "aws_instance" "my-existing-ec2" {
  # instance configuration
  ami           = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "FirstEC2Instance"
  }
  /*
  lifecycle {
    create_before_destroy = true # Creation before Destroying Existing Resource
    prevent_destroy = true # Stops Resource Destruction
    ignore_changes = [
      tags,
      instance_type
    ]
    replace_triggered_by = []
  }

  # depends_on = [aws_security_group.example_sec_grp] // Also Explicit Dependency
  */
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


/*
# Example for 'count' Argument 

resource "aws_instance" "multi_web_servers" {
  count = 4 # Creates 4 AWS Instances
  ami           = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "web-server-${count.index + 1}" # Adding Number based on 'count' for the Name
  }

}
####
# The Above Block Creates 4 AWS Instance of t3.micro Type with tag names
# web-server-1
# web-server-2
# web-server-3
# web-server-4
####
*/

/*
# Example for 'for_each' Argument 

variable "instance_types" {
  type = set(string)
  default = ["t3.micro", "t3.samll", "t3.large"]
}

resource "aws_instance" "multi_web_servers" {
  for_each = var.instance_types
  ami           = "ami-08ca1d1e465fbfe0c"
  instance_type = each.key 
}
####
# The Above Block Creates 3 AWS Instance of types
# t3.micro
# t3.small
# t3.large
####
*/

resource "aws_eip" "ec2-IP" {
  instance = aws_instance.my-existing-ec2.id // Implicit Dependency
}