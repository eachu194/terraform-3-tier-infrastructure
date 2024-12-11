variable "ami_id" {
    type = string
    description = "ami id"
    default = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  type = string
  description = "instance type"
  default = "t2.nano"
}

variable "tags" {
  type = map(string)
  description = "tags"
}

variable "subnet_id" {
    type = string
    description = "subnet to launch the instance" 
}

variable "vpc_id" {
    type = string
    description = "vpc id to launch sg"
}