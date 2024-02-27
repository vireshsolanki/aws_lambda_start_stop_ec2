resource "aws_vpc" "ec2-vpc" {
cidr_block = var.cidr-block
enable_dns_support = true
enable_dns_hostnames = true 
tags = {
  Name = "ec2-vpc"
}
}

data "aws_availability_zones" "available" {
}
 
/// creation of subnets
resource "aws_subnet" "public-subnet-1a" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.public-subnet-1a
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-1a"
    }
}
resource "aws_subnet" "public-subnet-1b" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.public-subnet-1b
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-1b"
    }
}
resource "aws_subnet" "private-subnet-1a" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.private-subnet-1a
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "private-subnet-1a"
    }
}
resource "aws_subnet" "private-subnet-1b" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.private-subnet-1b
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "private-subnet-1b"
    }
}

//creation of internet gateway and route table

resource "aws_internet_gateway" "ec2-igw" {
    vpc_id = aws_vpc.ec2-vpc.id
  tags = {
    Name = "ec2-igw"
  }
}



resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ec2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2-igw.id
  }

  tags = {
    Name = "public-rt"
  }
}
resource "aws_route_table_association" "public-subnet-1a-association" {
  subnet_id = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-subnet-1b-association" {
  subnet_id = aws_subnet.public-subnet-1b.id
  route_table_id = aws_route_table.public-rt.id
}



///creation of nat gateway and route table

resource "aws_eip" "eip-nat-gw-a" {
    vpc = true
    tags = {
      Name = "eip-nat-gw-a"
    }
}

resource "aws_nat_gateway" "nat-gw-a" {
  allocation_id = aws_eip.eip-nat-gw-a.allocation_id
  subnet_id     = aws_subnet.public-subnet-1a.id

  tags = {
    Name = "nat-gw-a"
  }
  depends_on = [ aws_internet_gateway.ec2-igw]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.ec2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-a.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-subnet-1a-association" {
  subnet_id = aws_subnet.private-subnet-1a.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-subnet-1b-association" {
  subnet_id = aws_subnet.private-subnet-1b.id   
  route_table_id = aws_route_table.private-rt.id
}




