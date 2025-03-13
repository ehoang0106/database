#subnet group
resource "aws_db_subnet_group" "my_db_subnet_group" {
  provider = aws
  name = "my-db-subnet-group"
  subnet_ids = [ aws_subnet.my_db_subnet_1.id, aws_subnet.my_db_subnet_2.id ]

  tags = {
    Name = "my-db-subnet-group"
  }
}

###database
resource "aws_db_instance" "my_db" {
  identifier = "my-db"
  provider = aws
  allocated_storage = 20
  db_name = "mydb"
  engine = "mysql"
  engine_version = "8.0.40"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  vpc_security_group_ids = [ aws_security_group.my_db_sg.id ]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  publicly_accessible = true
  depends_on = [ aws_security_group.my_db_sg ]
  
}