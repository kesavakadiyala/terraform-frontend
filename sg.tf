resource "aws_security_group" "allow-frontend-template-instance" {
  name        = "allow-frontend-template-instance"
  description = "allow-frontend-template-instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.PRIVATE_CIDR[0],data.terraform_remote_state.vpc.outputs.PRIVATE_CIDR[1]]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.PRIVATE_CIDR[0],data.terraform_remote_state.vpc.outputs.PRIVATE_CIDR[1]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-frontend-template-instance"
  }
}

