resource "aws_lb" "frontend" {
  name               = "frontend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-frontend-alb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET
  tags = {
    Name        = var.component
    Environment = var.ENV
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-lb-target-group.arn
  }
}