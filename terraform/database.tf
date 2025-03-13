###database
resource "aws_db_instance" "my_db" {
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
  publicly_accessible = true
}