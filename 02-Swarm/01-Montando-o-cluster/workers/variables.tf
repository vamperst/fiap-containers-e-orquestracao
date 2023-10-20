variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "aws_amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-03eb6185d756497f8"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "KEY_NAME" {
  default = "vockey"
}
variable "PATH_TO_KEY" {
  default = "/home/ubuntu/.ssh/vockey.pem"
}
variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
