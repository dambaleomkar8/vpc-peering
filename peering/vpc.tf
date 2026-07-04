#vpc 1
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "requester-vpc1"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "requester-subnet1"
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "requester-igw1"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
    }

    route {
    cidr_block = "172.168.0.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id
    }
  tags = {
    Name = "requester-rt1"
  }
}


resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

#vpc 2
resource "aws_vpc" "vpc2" {
  cidr_block = "172.168.0.0/16"
    tags = {
        Name = "accepter-vpc2"
    }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "172.168.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "accepter-subnet2"
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name = "accepter-igw2"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
    }

    route {
    cidr_block = "10.0.0.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_connection.id

    }    
  tags = {
    Name = "accepter-rt2"
  }
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt2.id
}
