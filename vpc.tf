provider "aws" {
  region     = "ap-south-1"
  access_key = "####################"
  secret_key = "######################################"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.16.0.0/24"

  tags = {
    Name = "pub-subnet"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.my_vpc.id

  #  route {
  #    cidr_block = "10.0.1.0/24"
  #    gateway_id = aws_internet_gateway.example.id
  #  }

  tags = {
    Name = "route-table-01"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}
