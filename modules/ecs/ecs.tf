# ECS cluster
resource "aws_ecs_cluster" "dt_ecs_cluster" {
  name = var.dt_ecs_cluster_name
}


# ECS task definition
resource "aws_ecs_task_definition" "dt_ecs_task" {
  family = var.dt_ecs_task_family
  container_definitions = jsonencode([
    {
      name      = var.dt_ecs_task_name
      image     = var.ecr_repo_url
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port 
        }
      ]
      memory = var.fargate_memory
      cpu    = var.fargate_cpu
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = var.ecs_region
          "awslogs-stream-prefix" = var.ecs_prefix
        }
      }
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.fargate_memory
  cpu                      = var.fargate_cpu
  execution_role_arn       = var.ecs_task_execution_role
}


# ECS service security group
resource "aws_security_group" "ecs_service_sg" {
  vpc_id      = var.ecs_vpc_id #passed in as variable from vpc module
  description = "Allows traffic only from load balancer"

  dynamic "ingress" {
    for_each = var.ecs_service_sg_ingress

    content {
      description     = ingress.value.description
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
      #cidr_blocks = [ "0.0.0.0/0" ]
      #cidr_blocks     = [var.ecs_cidr_block]
      security_groups = ["${var.ecs-lb}"]
    }
  }

  dynamic "egress" {
    for_each = var.ecs_service_sg_egress

    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "${var.project_name}_ecs_sg"
  }
}


# ECS service
resource "aws_ecs_service" "dt_ecs_service" {
  name            = var.dt_ecs_service_name
  cluster         = aws_ecs_cluster.dt_ecs_cluster.id
  task_definition = aws_ecs_task_definition.dt_ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = var.lb_target_group #passed in from alb module
    container_name   = var.dt_ecs_task_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = [var.ecs_priv_subs[0].id, var.ecs_priv_subs[1].id] #passed in from vpc module
    assign_public_ip = var.ecs_service_public_ip 
    security_groups  = [aws_security_group.ecs_service_sg.id]
  }
}
