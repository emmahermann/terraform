provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATFPLVLRKWV7OSSKX"
  secret_key = "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"
}



resource "aws_instance" "emmaec2" {
ami= "ami-000722651477bd39b"
instance_type = "t2.large"
tags = {
    "name" = "ubuntu"
}
}
