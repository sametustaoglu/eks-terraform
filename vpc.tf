resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "eks-${var.cluster-name}"
  }
}

resource "aws_nat_gateway" "nat" {
 allocation_id = aws_eip.nat.id
 subnet_id     = aws_subnet.public-a.id
 depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.eks.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "public"
  }
}

# resource "aws_route" "private_nat_gateway" {
#  route_table_id         = aws_route_table.private.id
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id         = aws_nat_gateway.nat.id
# }

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public.id
}



resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.0.0/22"
  availability_zone = "${var.aws_region}a"

  tags = {
    "Name"                            = "${var.aws_region}-a"
    "type"                            = "private"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.4.0/22"
  availability_zone = "${var.aws_region}b"

  tags = {
    "Name"                            = "${var.aws_region}-b"
    "type"                            = "private"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.8.0/22"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                            = "${var.aws_region}-a"
    "type"                            = "public"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.12.0/22"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                            = "${var.aws_region}-b"
    "type"                            = "public"
  }
}


resource "aws_eip" "nat" {
 vpc = true
}

resource "aws_vpc" "eks" {
  cidr_block = "${var.vpc-network}.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true 

  tags = {
    "Name"                                          = "eks-${var.cluster-name}"
    "kubernetes.io/cluster/eks-${var.cluster-name}" = "shared"
  }
}