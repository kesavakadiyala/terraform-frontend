bucket          = "roboshop-vpc"
key             = "frontend/prod/terraform.tfstate"
ENV             = "prod"
availability-zones = ["us-east-1a", "us-east-1b"]
INSTANCE_TYPE      = "t3.small"
KEYPAIR_NAME       = "devops"
component          = "frontend"
