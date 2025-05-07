terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-2-4-d0dgq9005akh4glkf8o0-4566.direct.lab-boris.fr"
  }
}

resource "random_id" "instance_suffix" {
  byte_length = 4
}

resource "aws_instance" "demo" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "AutoInstance-${random_id.instance_suffix.hex}"
  }
}
