locals {
  project_tags = {
    project      = "csqure-inventories"
    contact      = "devops@cspuareinc.net"
    application  = "payments"
    environment  = "${terraform.workspace}"
    CreationTime = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
  }
}