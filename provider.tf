terraform {
 backend "s3" {
 bucket = "shubhamtest1024"
 key = "globalstate/s3/terraform.tfstate"
 region = "eu-west-1"
 # Replace this with your DynamoDB table name!
 dynamodb_table = "Neeha-902903July-dblocks"
 encrypt = true
 }
}


provider "aws" {
  region = "eu-west-1"
}
