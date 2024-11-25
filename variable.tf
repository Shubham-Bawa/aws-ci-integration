variable "s3_bucket_name" {
  default     = "shubhamLKM25112024"
  description = "Name of the s3 bucket"
  type        = string
}
variable "s3_tags" {
  type = map

  default = {
    createdby   = "Neeha"
    environment = "dev"
  }
}

variable "s3_regions" {
  type    = string
  default = "eu-west-1"
}

