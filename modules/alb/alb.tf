# Load balancer security group
resource "aws_security_group" "dt_alb_sg" {
  vpc_id      = var.dt_vpc_id # passed in as variable from vpc module
  description = "Traffic into load balancer"

  dynamic "ingress" {
    for_each = var.alb_security_group_ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      #cidr_blocks = [ var.alb_cidr ]
      cidr_blocks = ["${var.open_cidr}"]
    }
  }

  dynamic "egress" {
    for_each = var.alb_security_group_egress

    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = ["${var.open_cidr}"]
    }
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}


# Application load balancer
resource "aws_alb" "dt_alb" {
  name            = "${var.project_name}-alb"
  subnets         = [var.public_subnets[0].id, var.public_subnets[1].id]
  security_groups = [aws_security_group.dt_alb_sg.id]
}


# Target group 
resource "aws_lb_target_group" "dt_tg" {
  name        = "${var.project_name}-tg"
  port        = var.http_port
  protocol    = var.http_protocol
  target_type = var.target_type
  vpc_id      = var.dt_vpc_id

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    protocol            = var.http_protocol
    matcher             = var.matcher
    path                = var.path
    interval            = var.interval
  }
}


# Listener
resource "aws_lb_listener" "dt_listener" {
  load_balancer_arn = aws_alb.dt_alb.arn
  port              = var.http_port
  protocol          = var.http_protocol


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dt_tg.arn
  }
}
