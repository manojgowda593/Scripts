resource "aws_vpc" "New_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "New_VPC"
  }
}

resource "aws_subnet" "Public_1" {
  vpc_id     = aws_vpc.New_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Subnet1"
  }
}

resource "aws_subnet" "Public_2" {
  vpc_id     = aws_vpc.New_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "Subnet2"
  }
}

resource "aws_internet_gateway" "New_gw" {
  vpc_id = aws_vpc.New_vpc.id
  tags = {
    Name = "new_ng"
  }
}

resource "aws_route_table" "Route1" {
  vpc_id = aws_vpc.New_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.New_gw.id
  }
  tags = {
    Name = "new_route"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Public_1.id
  route_table_id = aws_route_table.Route1.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Public_2.id
  route_table_id = aws_route_table.Route1.id
}
