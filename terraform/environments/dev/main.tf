terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
	bucket		= "hybrid-devsecops-tf-state-etb101-bucket1-0417"
	key		= "dev/terraform.tfstate"
	region 		= "us-east-1"
	
	#keep this (still valid)
	dynamodb_table	= "terraform-locks"
	
	# optional ( new update)
	use_lockfile	= true
  }
}

  provider "aws" {
	region = "us-east-1"
  }

  module "vpc" {
	source = "../../modules/vpc"

	cidr_block 		=	"10.0.0.0/16"
	public_subnets	=	["10.0.1.0/24", "10.0.2.0/24"]
	private_subnets	=	["10.0.3.0/24",	"10.0.4.0/24"]
	region			=	"us-east-1"
  }


