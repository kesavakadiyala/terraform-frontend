resource "aws_lb_listener" "frontend-lb-listener-dev" {
  count = var.ENV == "dev" ? 1 : 0
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.FRONTEND_ALB_ARN_DEV
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-lb-target-group.arn
  }
}

resource "aws_lb_listener" "backend-dev" {
  count = var.ENV == "dev" ? 1 : 0
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.BACKEND_ALB_ARN_DEV
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener" "frontend-lb-listener-prod" {
  count = var.ENV == "prod" ? 1 : 0
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.FRONTEND_ALB_ARN_PROD
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-lb-target-group.arn
  }
}

resource "aws_lb_listener" "backend-prod" {
  count = var.ENV == "prod" ? 1 : 0
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.BACKEND_ALB_ARN_PROD
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}