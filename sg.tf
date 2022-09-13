resource "aws_security_group" "cluster" {
  name        = "eks-${var.cluster-name}-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-${var.cluster-name}"
  }
}

# resource "aws_security_group" "bastion_sg" {
#   name        = "eks-${var.cluster-name}-bastion"
#   description = "bastion_host"
#   vpc_id      = aws_vpc.eks.id
  

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # ingress   {
#   #   cidr_blocks = ["0.0.0.0/0"]
#   #   description = "allow 22,80,443"
#   #   from_port = 443
#   #   protocol = "tcp"
#   #   to_port = 443
#   # } 

#   # ingress   {
#   #   cidr_blocks = ["0.0.0.0/0"]
#   #   description = "allow 22,80,443"
#   #   from_port = 80
#   #   protocol = "tcp"
#   #   to_port = 80
#   # } 

#   # ingress   {
#   #   cidr_blocks = ["0.0.0.0/0"]
#   #   description = "allow 22,80,443"
#   #   from_port = 22
#   #   protocol = "tcp"
#   #   to_port = 443
#   # } 
  
#   dynamic "ingress" {
#     for_each = var.secgr-dynamic-ports
#     content {
#       from_port = ingress.value
#       to_port = ingress.value
#       protocol = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#   }
# }

#   tags = {
#     Name = "eks-${var.cluster-name}-bastion"
#   }
# }

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.eks.id

  dynamic "ingress" {
    for_each = var.secgr-dynamic-ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

  # ingress {
  #   description = "SSH into VPC"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    description = "Outbound Allowed"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }