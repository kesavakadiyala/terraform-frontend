resource "aws_launch_template" "launch_template" {
  count = length(var.availability-zones)
  name = var.component
  image_id = data.aws_ami.frontend-ami.id
  instance_type = "t2.micro"
  key_name = "devops"
  vpc_security_group_ids = [aws_security_group.allow-frontend-instance.id]
  monitoring {
    enabled = true
  }
  placement {
    availability_zone = var.availability-zones[count.index]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.component}-${var.ENV}-template",
      Zone = var.availability-zones[count.index]
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  count                     = length(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET)
  name                      = "frontend"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = [element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET, count.index)]
  launch_template {
    id                      = element(aws_launch_template.launch_template.*.id, count.index)
    version                 = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "Frontend"
    propagate_at_launch = false
  }
}