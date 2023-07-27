//Create Primary VPC
resource "aws_vpc" "primary" {
  provider             = aws.zone1
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

//Create IGW
resource "aws_internet_gateway" "primary" {
  provider = aws.zone1
  vpc_id   = aws_vpc.primary.id
}

//Route Table
resource "aws_route" "primary-internet_access" {
  provider               = aws.zone1
  route_table_id         = aws_vpc.primary.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

//Subnet-A
resource "aws_subnet" "primary-az1" {
  provider                = aws.zone1
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.zone1}a"
}

//Subnet-B
resource "aws_subnet" "primary-az2" {
  provider                = aws.zone1
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.zone1}b"
}

/*Security-Group
Ingress - Port 80 -- limited to instance
          Port 22 -- Open to ssh without limitations
Egress  - Open to All*/

resource "aws_security_group" "primary_default" {
  provider    = aws.zone1
  name_prefix = "default-"
  description = "Default security group for all instances in ${aws_vpc.primary.id}"
  vpc_id      = aws_vpc.primary.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
