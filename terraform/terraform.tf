terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {
    path = "state/terraform.tfstate"    # 상태(State) 저장 위치
  }
}