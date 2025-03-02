provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAXTORPGTJSSW:L43LZJQ6V"
  secret_key = "jjFS1GGfhIggxdjuJnnaky8Hinwknys+h4LHE9qyIXvl"
}

output "aws_instance" {
  value = aws_instance.web.ami
}

output "aws_instance-pub-ip" {
  value = aws_instance.web.public_ip
}

output "aws_vpc_secure" {
  value = aws_vpc.my-vpc.arn
  sensitive = true
}

locals {
  # Common tags to be assigned to all resources
  usa = {
   Name  = "usa-project"
   Owner   = "abdul kadir"
}
}

resource "aws_instance" "web" {
  ami           = "ami-027951e78de46a00e"
  instance_type = "t3.micro"
  tags          = local.usa
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = local.usa
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.100.0/24"
  tags       = local.usa
}

locals {
  # Common tags to be assigned to all resources
  uk = {
   Name  = "uk-project"
   Owner   = "abdul kadir"
}
}

resource "aws_instance" "web1" {
  ami           = "ami-027951e78de46a00e"
  instance_type = "t3.micro"
  tags          = local.uk
}

resource "aws_vpc" "my-vpc-uk" {
  cidr_block = "10.0.0.0/16"
  tags       = local.uk
}

resource "aws_subnet" "private-subnet-uk" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.20.0/24"
  tags       = local.uk
}
