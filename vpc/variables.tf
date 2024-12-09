variable "vpc_cidr_block" {
  type = string
  description = "cidr block for vpc"
  default = "10.0.0.0/16"
}

variable "public_subnet1_cidr_block" {
  type = string
  description = "cidr block for public subnet 1"
  default = "10.0.1.0/24"
}

variable "public_subnet2_cidr_block" {
  type = string
  description = "cidr block for public subnet 2"
  default = "10.0.2.0/24"
}

variable "private_subnet1_cidr_block" {
  type = string
  description = "cidr block for private subnet 1"
  default = "10.0.3.0/24"
}

variable "private_subnet2_cidr_block" {
  type = string
  description = "cidr block for private subnet 2"
  default = "10.0.4.0/24"
}

variable "availability_zone" {
  type = list(string)
  description = "list of availability zones"
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_name_tag" {
  type = string
  description = "Name for vpc"
  default = "dev-vpc"
}

variable "subnet_name_tags" {
  type = list(string)
  description = "Names for all subnets"
  default = [ "public-subnet1", "public-subnet2", "private-subnet1", "private-subnet2" ]
  
}

variable "tags" {
  type = map
  description = "tags"
}

