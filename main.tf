provider "aws" {
  region = "us-west-2"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-087f352c165340ea1" # Amazon Linux 2 AMI (us-west-2)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "demo-web"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "storage" {
  bucket = "my-demo-bucket-${random_string.suffix.result}"
  tags = {
    Name = "demo-bucket"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}