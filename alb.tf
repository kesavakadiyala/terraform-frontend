resource "aws_lb_listener" "frontend-lb-listener" {
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.FRONTEND_ALB_ARN
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.vpc.outputs.FRONTEND_ALB_ARN
  }
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = data.terraform_remote_state.vpc.outputs.BACKEND_ALB_ARN
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

resource "aws_route53_record" "backend-alb" {
  count               = length(var.BACKEND_COMPONENTS)
  name                = "${element(var.BACKEND_COMPONENTS, count.index)}-${var.ENV}"
  type                = "CNAME"
  zone_id             = data.terraform_remote_state.vpc.outputs.HOSTED_ZONE_ID
  ttl                 = "300"
  records             = [data.terraform_remote_state.vpc.outputs.BACKEND_ALB_DNSNAME]
}