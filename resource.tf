resource "aws_s3_bucket" "bckt" {
  bucket = var.s3_bucket_name
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.bckt.id

  rule {
    apply_server_side_encryption_by_default {
    sse_algorithm = "AES256"
   }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bckt.id
  
  versioning_configuration {
  status = "Enabled"
 }
}



resource "aws_dynamodb_table" "locks" {
  name = "Shubham-07July-dblocks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}


output "s3_bucket_arn" {
  value       = aws_s3_bucket.bckt.arn
  description = "arn of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.locks.name
  description = "The name of the DynamoDB table"
  
}

################################### DATA ###############################################

data "aws_availability_zones" "available" {}

data "aws_ami" "aws-linux" {
  most_recent = true ## to get the latest and greatest image ##
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

################################### RESOURCES ###############################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = "true"

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

resource "aws_subnet" "subnet" {
  cidr_block              = var.subnet_address_space
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]

}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-subnet" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #

resource "aws_security_group" "aws-sg" {
  name   = "mysecuritygroup"
  vpc_id = aws_vpc.vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.7.2.233/32"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["3.7.2.233/32"]
  }

  # outbound internet access
}

# INSTANCES #
resource "aws_instance" "instance1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.aws-sg.id]
  key_name               = var.key_name
  
   


  }
  }



output "aws_instance_public_dns" {
  value = aws_instance.instance1.public_dns
}

