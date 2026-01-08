resource "aws_vpc" "vpc1" {
  tags = {
    Name = "My-VPC"
  }
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  tags = {
    Name = "public-subnet"
  }
  cidr_block              = var.pub_subnet_cidr_block
  vpc_id                  = aws_vpc.vpc1.id
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "my-igw"
  }
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "pub-rt" {
  tags = {
    Name = "Public-route-table"
  }
  vpc_id = aws_vpc.vpc1.id

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = var.allow_all
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_security_group" "sg" {
  name   = "tf-sg"
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = [var.allow_all]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }
}
