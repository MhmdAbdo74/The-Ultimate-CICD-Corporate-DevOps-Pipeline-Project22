resource "aws_security_group" "Jenkins-VM-SG" {
  name        = "Jenins,nexus,sonarqube M-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000,8081] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-VM-SG"
  }
}
resource "aws_instance" "web" {
  ami                    = var.ami      #change ami id for different region
  instance_type          = var.type
  key_name               = var.KEY_NAME              #change key name as per your setup
  vpc_security_group_ids = [aws_security_group.Jenkins-VM-SG.id]
  user_data              = templatefile("../modules/jenkins/install.sh", {})

  subnet_id              = var.subnet_id

  tags = {
    Name = "Jenkins"
  }

  root_block_device {
    volume_size = 30
  }
}