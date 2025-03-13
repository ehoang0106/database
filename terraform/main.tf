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

}