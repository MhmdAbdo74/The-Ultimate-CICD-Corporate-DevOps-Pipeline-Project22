variable "ports" {
  default = [
    { from_port = 30000, to_port = 32767 },
    { from_port = 3000, to_port = 10000 },
    { from_port = 443, to_port = 443 },
    { from_port = 25, to_port = 25 },
    { from_port = 6443, to_port = 6443 },
    { from_port = 22, to_port = 22 },
    { from_port = 80, to_port = 80 },
    { from_port = 465, to_port = 465 },
  ]
}

variable "egress_ports" {
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}
variable "ami" {
  description = "The ID of the AMI to use for the EC2 instances"
}
variable "type" {
  description = "The type of EC2 instance to launch"
}
variable "instance_count" {
  description = "The number of EC2 instances to launch"
}
variable "KEY_NAME" {
  
}
variable "vpc_id" {
  
}
variable "subnet_id" {
  
}