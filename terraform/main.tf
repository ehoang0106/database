###vpc

resource "aws_vpc" "my_db_vpc" {
  provider = aws
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-db-vpc"
  }
}

###secondary ipv4 cidr block
resource "aws_vpc_ipv4_cidr_block_association" "second_cidr_block" {
  vpc_id = aws_vpc.my_db_vpc.id
  cidr_block = "10.1.0.0/16"
}

###subnet 1
resource "aws_subnet" "my_db_subnet_1" {
  vpc_id = aws_vpc.my_db_vpc.id
  cidr_block = "10.0.0.0/16"
  availability_zone = "us-west-1a"
  depends_on = [ aws_vpc_ipv4_cidr_block_association.second_cidr_block ]

  tags = {
    Name = "my-db-subnet-1"
  }
}

###subnet 2
resource "aws_subnet" "my_db_subnet_2" {
  vpc_id = aws_vpc.my_db_vpc.id
  cidr_block = "10.1.0.0/16"
  availability_zone = "us-west-1c"
  depends_on = [ aws_vpc_ipv4_cidr_block_association.second_cidr_block ]

  tags = {
    Name = "my-db-subnet-2"
  }
}

###internet gateway
resource "aws_internet_gateway" "my_db_igw" {
  vpc_id = aws_vpc.my_db_vpc.id

  tags = {
    Name = "my-db-igw"
  }
}

###route table
resource "aws_route_table" "my_db_rt" {
  vpc_id = aws_vpc.my_db_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_db_igw.id
  }

  tags = {
    Name = "my-db-rt"
  }
}

###associate route table with subnet 1
resource "aws_route_table_association" "my_db_rt_association_1" {
  subnet_id = aws_subnet.my_db_subnet_1.id
  route_table_id = aws_route_table.my_db_rt.id
}

###associate route table with subnet 2
resource "aws_route_table_association" "my_db_rt_association_2" {
  subnet_id = aws_subnet.my_db_subnet_2.id
  route_table_id = aws_route_table.my_db_rt.id
}

###security group
resource "aws_security_group" "my_db_sg" {
  vpc_id = aws_vpc.my_db_vpc.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["74.212.237.134/32"]
    description = "Allow MySQL traffic from my IP"
  }

  tags = {
    Name = "my-db-sg"
  }
}