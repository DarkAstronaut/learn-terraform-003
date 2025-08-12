resource "aws_instance" "tf-ec2-instance-1" {
  ami           = "ami-0169aa51f6faf20d5"
  instance_type = "t3.micro"

  tags = {
    Name = "demo-server-1"
  }
}

resource "aws_instance" "tf-ec2-instancce-2" {
  provider      = aws.west
  ami           = "ami-06e11c4cc68c362dd" # For West Region (us-west-1)
  instance_type = "t3.micro"

  tags = {
    Name = "demo-server-2"
  }
}