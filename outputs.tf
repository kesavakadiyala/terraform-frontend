output "BACKEND_LISTENER_ARN_DEV" {
  value = aws_lb_listener.backend-dev.arn
}

output "BACKEND_LISTENER_ARN_PROD" {
  value = aws_lb_listener.backend-prod.arn
}
