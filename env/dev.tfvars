bucket          = "roboshop-vpc"
key             = "frontend/dev/terraform.tfstate"
ENV             = "dev"
availability-zones = ["us-east-1a", "us-east-1b"]
INSTANCE_TYPE      = "t2.micro"
KEYPAIR_NAME       = "devops"