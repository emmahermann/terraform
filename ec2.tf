provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATFPLVLRKWV7OSSKX"
  secret_key = "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"
}
resource "aws_vpc" "emmavpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "EmmaVPC"
  }
}


resource "aws_subnet" "public1-sub" {
  vpc_id     = aws_vpc.emmavpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "public1-sub"
  }
}
resource "aws_subnet" "public2-sub" {
  vpc_id     = aws_vpc.emmavpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public2-sub"
  }
}
resource "aws_subnet" "private-sub" {
  vpc_id     = aws_vpc.emmavpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-sub"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.emmavpc.id
  tags = {
    Name = "gw"
  }
}
resource "aws_route_table" "publicroute-table" {
   vpc_id= aws_vpc.emmavpc.id 
    tags = {
        name = "publicroute-table"
    }
   
}
resource "aws_route" "publicroute" {
route_table_id =   aws_route_table.publicroute-table.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "rtass" {
subnet_id = aws_subnet.public1-sub.id
route_table_id = aws_route_table.publicroute-table.id
}
resource "aws_route_table_association" "rtass2" {
subnet_id = aws_subnet.public2-sub.id
route_table_id = aws_route_table.publicroute-table.id
}

resource "aws_instance" "emmaec2" {
ami= "ami-000722651477bd39b"
instance_type = "t2.micro"
tags = {
    "name" = "ubinto1"
}
subnet_id = aws_subnet.public1-sub.id

}
