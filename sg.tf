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

resource "aws_security_group" "bastion_sg" {
  name        = "eks-${var.cluster-name}-bastion"
  description = "bastion_host"
  vpc_id      = aws_vpc.eks.id
  # depends_on = [
  #   aws_instance.bastion
  # ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress   {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow 22,80,443"
    from_port = 443
    protocol = "tcp"
    to_port = 443
  } 

  ingress   {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow 22,80,443"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  } 

  ingress   {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow 22,80,443"
    from_port = 22
    protocol = "tcp"
    to_port = 443
  } 

  tags = {
    Name = "eks-${var.cluster-name}-bastion"
  }
}