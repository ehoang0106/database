#create a database and use mysql as engine, version 8.0.40,
#this database main region is in us-west-1, then replica to us-east-1

resource "aws_db_instance" "my_db" {
  allocated_storage = 20
  db_name = "my-db"
  engine = "mysql"
  engine_version = "8.0.40"
  instance_class = "db.t4g.micro"
  username = "admin"
  password = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true

  #setting connectivity

  #vpc
  

}