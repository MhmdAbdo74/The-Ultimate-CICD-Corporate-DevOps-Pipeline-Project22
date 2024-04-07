resource "aws_security_group" "example_sg" {
  name        = "ec2-k8s-SG"
  description = "security group for K8S EC2"
    vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_ports
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "K8S_sg"
  }
}
resource "aws_instance" "example_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.type
  key_name               = var.KEY_NAME
 user_data  = templatefile("../modules/K8S-EC2/install-docker.sh", {})
    subnet_id     = var.subnet_id
  security_groups = [aws_security_group.example_sg.id]

  tags = {
    Name = "k8s-${count.index + 1}"
  }
    root_block_device {
    volume_size = 30
  }
}