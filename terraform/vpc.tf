# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "one" {
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "two" {
  vpc_id     = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "10.0.2.0/24"
}