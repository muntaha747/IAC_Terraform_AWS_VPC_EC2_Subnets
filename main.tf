######################################################################
# REGION
######################################################################

provider "aws" {
  region = var.Geo_Location
}

######################################################################
# VPC
######################################################################
resource "aws_vpc" "Project_VPC" {
  cidr_block = var.VPC_CLoud

  tags = {
    Name = "Virtual Private Cloud"
  }
}

######################################################################
# Internet Gateway and attached Internet Gateway to the VPC.
######################################################################

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Project_VPC.id

  tags = {
    Name = "IGW-VPC2"
  }
}


######################################################################
# Public Route Table
######################################################################

resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.Project_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}



######################################################################
# Subnets
######################################################################

resource "aws_subnet" "Subnet-1" {
  vpc_id                  = aws_vpc.Project_VPC.id
  cidr_block              = var.Subnet_ID1
  availability_zone       = var.AZ_1a
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "Subnet-2" {
  vpc_id                  = aws_vpc.Project_VPC.id
  cidr_block              = var.Subnet_ID2
  availability_zone       = var.AZ_1a
  map_public_ip_on_launch = false

  tags = {
    Name = "Subnet-2"
  }
}

resource "aws_subnet" "Subnet-3" {
  vpc_id                  = aws_vpc.Project_VPC.id
  cidr_block              = var.Subnet_ID3
  availability_zone       = var.AZ_1b
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-3"
  }
}


resource "aws_subnet" "Subnet-4" {
  vpc_id                  = aws_vpc.Project_VPC.id
  cidr_block              = var.Subnet_ID4
  availability_zone       = var.AZ_1b
  map_public_ip_on_launch = false

  tags = {
    Name = "Subnet-4"
  }
}


######################################################################
# Subnets association with the public route table.
######################################################################

resource "aws_route_table_association" "Sub1-Route-Association" {
  subnet_id      = aws_subnet.Subnet-1.id
  route_table_id = aws_route_table.Public_Route_Table.id
}

resource "aws_route_table_association" "Sub3-Route-Association" {
  subnet_id      = aws_subnet.Subnet-3.id
  route_table_id = aws_route_table.Public_Route_Table.id
}
######################################################################
# Security Group (Firewall)
######################################################################

resource "aws_security_group" "EC2_SG" {
  name        = var.EC2_Firewall
  description = "Allow All inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Project_VPC.id

  tags = {
    Name = "SSGVPC"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


######################################################################
# EC2S
######################################################################

resource "aws_instance" "Public1_EC2" {
  ami                    = var.AMIID
  instance_type          = var.EC2_Instance_Public
  key_name               = var.Key_Pair
  vpc_security_group_ids = [aws_security_group.EC2_SG.id]
  subnet_id              = aws_subnet.Subnet-1.id

  tags = {
    Name = "Public1_EC2"
  }
}

resource "aws_instance" "Public2_EC2" {
  ami                    = var.AMIID
  instance_type          = var.EC2_Instance_Public
  key_name               = var.Key_Pair
  vpc_security_group_ids = [aws_security_group.EC2_SG.id]
  subnet_id              = aws_subnet.Subnet-3.id

  tags = {
    Name = "Public2_EC2"
  }
}


resource "aws_instance" "Private_EC2" {
  ami                    = var.AMIID
  instance_type          = var.EC2_Instance_Private
  key_name               = var.Key_Pair
  vpc_security_group_ids = [aws_security_group.EC2_SG.id]
  subnet_id              = aws_subnet.Subnet-2.id

  tags = {
    Name = "Private_EC2"
  }
}

