/*
Verbose Loggin is used for 
  - Debugging
  - Understanding Changes made by Terraform
  - Learn and Explore how Terraform works behind the scenes

Must configure following Terraform EnvVariables:
  - DEBUG
  - TRACE
  - WARN
  - INFO
  - ERROR
*/

/*
Enabling TRACE
$ export TF_LOG="TRACE"
Adding Location for TRACE
$ export TF_LOG_PATH="./logs/terraform_TRACE.log"
*/

/*
From Terraform ver. 0.15, logging level for Core Application can be handled 
seperately from providers, making following command
  $ export TF_LOG="ERROR"
track only errors for core application

For Providers, the following commmand
  $ export TF_LOG_PROVIDER="TRACE"
makes provider-related logs set to TRACE and capture all the details
*/

/*
Use the following command to remove changes for logs
  $ unset TF_LOG
*/

/*
resource "aws_instance" "my-existing-ec2" {
  # instance configuration
  ami = "ami-08ca1d1e465fbfe0c"
  instance_type = "t3.micro"

  tags = {
    Name = "FirstEC2Instance"
  }
}
*/


