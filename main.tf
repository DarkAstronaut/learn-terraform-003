/*
The EC2 Instance - "FirstEC2Instance" created in AWS will be imported
using 'terraform import' 

- Get Instnace ID and use it with 
    'terrafrom import aws_instance.my-existing-ec2 <Instance ID>'

- Fill the details in resource block
  - Use terraform state show aws_instance.myexisting-ec2 to get the details
*/

resource "aws_instance" "my-existing-ec2" {
  # instance configuration
  ami = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "FirstEC2Instance"
  }
}