resource "aws_eip" "bastion_eip"{
    instance = aws_instance.bastion.id
    vpc = true
    depends_on = [
      aws_instance.bastion,
      aws_internet_gateway.igw
    ]
}

resource "aws_instance" "bastion" {
  ami = "ami-08d4ac5b634553e16" # us-east-1 ubuntu 20.04
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-a.id
  key_name = "var.inst_key_pair"
#   vpc_security_group_ids = [ "aws_security_group.bastion_sg.id" ]
  tags = {
    Name = "bastion"
  }
}