variable "s3_bucket_name" {
  default     = "shubhamtestlkm434343"
  description = "Name of the s3 bucket"
  type        = string
}
variable "s3_tags" {
  type = map

  default = {
    createdby   = "Shubham"
    environment = "dev"
  }
}

variable "s3_regions" {
  type    = string
  default = "eu-west-1"
}


variable "private_key_path"{
  type = string
  default = "./terraformkp.pem"
}
variable "key_name" {
  type = string
 description = "key name"
 default = "Neeharika_Terraform"
}
variable "region" {
  type    = string
  default = "eu-west-1"
  description = "Name of the region to create resource"
}
variable "network_address_space" {
  default = "10.1.0.0/16"
}
variable "subnet_address_space" {
  default = "10.1.0.0/24"
}
variable "countsec2" {
  type = number
  default = 2
}




