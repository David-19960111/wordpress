resource "aws_alb" "my_alb" {
  name = var.lb_name
  internal = false 
  load_balancer_type = var.lb_load_balancer_type
  ip_address_type = var.lb_ip_address_type
  security_groups = var.security_group_alb[*]
  subnets = var.subnets_public_alb[*]
}

resource "aws_lb_target_group" "my_alb_tg" {
    health_check {
      interval = 300
      path = "/"
      protocol = "HTTP"
      timeout = 60
      healthy_threshold = 5
      unhealthy_threshold = 5
    }
    name = var.lb_tg_name
    port = var.lb_tg_port
    protocol = var.lb_tg_protocol
    vpc_id = var.vpc_id
    target_type = var.lb_tg_target_type
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.my_alb_tg.arn
  target_id = ""
}

resource "aws_lb_listener" "my_alb_listner" {
  load_balancer_arn = aws_alb.my_alb.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_alb_tg.arn
  }
}