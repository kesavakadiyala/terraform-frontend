data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket      = var.bucket
    key         = "vpc/${var.ENV}/terraform.tfstate"
    region      = "us-east-1"
  }
}

output "VPC_ID" {
  value = data.terraform_remote_state.vpc.outputs.VPC_ID
}