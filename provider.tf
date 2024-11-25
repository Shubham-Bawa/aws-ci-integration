terraform {
 backend "s3" {
 bucket = "shubhamtestlkm23"
 key = "globalstate/s3/terraform.tfstate"
 region = "eu-west-1"
 # Replace this with your DynamoDB table name!
 dynamodb_table = "Shubham-06July-dblocks"
 encrypt = true
 }
}


provider "aws" {
  region = "us-east-1"
}
