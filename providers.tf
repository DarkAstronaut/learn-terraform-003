terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0" # 5.31.x Series for Hashicorp AWS Version
    }
  }
}

provider "aws" {
  # Default Region and IAM User
  region = "us-east-2"
  # profile = "Ghost_tf"
}
