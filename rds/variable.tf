variable "private_subnet1" {
  type = string
  description = "subnet1 id"
  
}

variable "private_subnet2" {
  type = string
  description = "subnet2 id"
  
}

variable "storage" {
  default = 10
}

variable "engine_type" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "instance_class" {
  default = "db.t3.micro"   
}

variable "username" {
  default = "admin"
}

variable "password" {
  default = "admin123"
}

variable "final_snapshot" {
  default = true
}

variable "parameter_group" {
  default = "default.mysql5.7"
}

variable "tags" {
  type = map(string)
  description = "tags"
  
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "vpc_cidr" {
  type = string
  description = "vpc cidr range"
}