resource "aws_instance" "my-existing-ec2" {
  # instance configuration
  ami = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "FirstEC2Instance"
  }
}
