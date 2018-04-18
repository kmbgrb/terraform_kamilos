variable "my_ipv4" {
  description = "My current ip address"
  default     = "89.64.3.191/32"
}

variable "region" {
  default = "eu-west-1"
}

variable "ami" {
  default = "ami-2d386654"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "tag_name" {
  default = "kamilos"
}

variable "iam_instance_profile" {
  default = "ecsInstanceRole"
}

variable "key_name" {
  default = "aws-kamilos"
}
