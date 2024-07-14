# RDS Security group
resource "aws_security_group" "rds_sg" {
  vpc_id = var.dt_vpc

  dynamic "ingress" {
    for_each = var.rds_sg_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["${var.rds_sg_cidr}"]
    }
  }

  dynamic "egress" {
    for_each = var.rds_sg_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  depends_on = [var.alb_sg]

  tags = {
    Name = "${var.project_name}_rds_sg"
  }
}


# Subnet group
resource "aws_db_subnet_group" "dt_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.private_subnets[0].id, var.private_subnets[1].id]

  tags = {
    Name = "${var.project_name}_db_subnet_group"
  }
}


# Parameter group
resource "aws_db_parameter_group" "dt_parameter_group" {
  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name  = "log_connections"
    value = true
  }
}


# Reading availability zones from region
data "aws_availability_zones" "avail" {}


#DB instance
resource "aws_db_instance" "default" {
  allocated_storage            = var.allocated_storage
  identifier                   = var.identifier
  db_name                      = var.db_name
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  username                     = var.username
  password                     = var.password
  parameter_group_name         = aws_db_parameter_group.dt_parameter_group.name
  skip_final_snapshot          = var.skip_final_snapshot
  db_subnet_group_name         = aws_db_subnet_group.dt_subnet_group.name
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
  storage_encrypted            = var.storage_encrypted
  performance_insights_enabled = var.performance_insights_enabled
  availability_zone            = element(data.aws_availability_zones.avail.names, 1)



  depends_on = [var.dt_vpc]

  tags = {
    Name = "${var.project_name}_database"
  }
}