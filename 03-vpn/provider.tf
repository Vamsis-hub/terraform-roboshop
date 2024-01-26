terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }


 backend "s3"{
   bucket = "devops-vamsi"
   key = "vpn"
   region = "us-east-1"
   dynamodb_table = "devops-locking"
  }

}  

provider "aws" {
 region = "us-east-1"

}