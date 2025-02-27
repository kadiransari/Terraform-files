provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAXTORPG/rdTL43LZJQ6V"
  secret_key = "jjFS1GG/iifhIggxdjuJy8Hinwknys+h4LHE9qyIXvl"
}

variable "instancetype" {
  type = list
  default = ["t2.small", "t2.nano", "t2.medium"]
}  

variable "instancetag" {
  type = list 
  default = ["dev-team", "qa-team", "prod-team"]
}

resource "aws_instance" "dev" {
   ami = "ami-0d682f26195e9ec0f"
   instance_type = var.instancetype[count.index]
   count = 10

   tags = {
     Name = var.instancetag[count.index]
   }  
}
