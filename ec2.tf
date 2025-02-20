[root@ip-172-31-1-22 Terraform-files]# cat ec2.tf 
provider "aws" {
  region     = "ap-south-1"
  access_key = "####################"
  secret_key = "######################################"
}

# Create EC2-instance
resource "aws_instance" "ec2-instance" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t3.micro"
  key_name = "terraform-key"
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]

  tags = {
    Name = "ec2-instance"
  }
}

# create a key pair.
resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC02wCai8rxUL5LFSURcIudh7brwRoyrMmfCugTOW7gHTNWrKDXIc6WHrA173lYx9h/UI0V20z/glMJ+57KHYzKKjuU+ROa/lx4zq0pr3ESG55HhwLOCq9nsKWS7Y7Fagf7E4NReDDTGtyew3BvNqzBrytiOEKow/l2qWeBhcTl8XOail0yFkcKl2DHTjaD/K4vc0iJWL6HlDaiFlUJ8p+oUktRpqBGAT9VS0WKJevtwXAWwypqvcNfpYSMGvN6N1ApoiHmbvglGFrIqlbkiq0L5M4Lp40hnCPt6xGqQgcy4gX4q2IdNGMO2djWqylD7QLeVALXAZ4ZngrWBuhE5d2fiFMgUlV1tCkQPfcajXlt5ywbLlPqGhhcGryhTCPtZyYs4glBn8ruS+EMphLqtylITtyaVdqk0vQdutGBBJbb2PFSin3l8xLVYJNnj3z0FbjgFCA6CkosLrzUikX5Ff07xLqewi3MGMMwQpPN+OL8FMghjnunQqHHcihhGSK7BKE= root@ip-172-31-1-22.ap-south-1.compute.internal"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# create a security group and allow multiple port.
resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "terraform-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "allow_http" {
  security_group_id = aws_security_group.terraform-sg.id
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
