provider "aws" {
  region     = "us-west-2"
  access_key = "###################"
  secret_key = "######################################"
}

#string type variable
variable "elbtag" {
  type = string
}

#List type variable
variable "azname" {
  type = list
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
 
}

#Number type variable
variable "elb-timeout" {
  type = number
  default = "100"

}
# Create a new load balancer
resource "aws_elb" "bar" {
  name               = var.elbtag
  availability_zones = var.azname

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = var.elb-timeout
  connection_draining         = true
  connection_draining_timeout = var.elb-timeout

  tags = {
    Name = "foobar-terraform-elb"
  }
}
