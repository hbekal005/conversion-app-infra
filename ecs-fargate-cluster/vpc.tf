# Declare the availability zone data source
data "aws_availability_zones" "ecs-available-zones" {
  state = "available"
}

# Creating a VPC
resource "aws_vpc" "conversion-app-vpc" {
  cidr_block       = var.vpc_cidr_block[terraform.workspace]
  instance_tenancy = "default"

  tags = {
    Name = "${terraform.workspace}-conversion-app-vpc"
  }
}

#Creating all the public resources for the VPC

# Creating  subnet
# The cidrsubnet function is used to calculate the CIDR block for each subnet
resource "aws_subnet" "ecs-subnet-01" {
  vpc_id                  = aws_vpc.conversion-app-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block[terraform.workspace], var.subnet_mask, var.subnet_count)
  availability_zone       = element(data.aws_availability_zones.ecs-available-zones.names, 0)
  map_public_ip_on_launch = true
  tags = {
    Name = "${terraform.workspace}-ecs-subnet-01"
  }
}

resource "aws_subnet" "ecs-subnet-02" {
  vpc_id                  = aws_vpc.conversion-app-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block[terraform.workspace], var.subnet_mask, var.subnet_count + 1)
  availability_zone       = element(data.aws_availability_zones.ecs-available-zones.names, 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "${terraform.workspace}-ecs-subnet-02"
  }
}


# Creating an internet gateway
resource "aws_internet_gateway" "conversion-app-igw" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "${terraform.workspace}-conversion-app-igw"
  }
}



# Creating a ECS Route Table
resource "aws_route_table" "ecs-route-table" {
  vpc_id = aws_vpc.conversion-app-vpc.id
  tags = {
    Name = "${terraform.workspace}-ecs-route-table"
  }
}



# Create Routes for the ECS Route Table
resource "aws_route" "ecs-route" {
  route_table_id         = aws_route_table.ecs-route-table.id
  destination_cidr_block = var.all_cidr_block
  gateway_id             = aws_internet_gateway.conversion-app-igw.id
}



#Route Table Association
resource "aws_route_table_association" "rtb-subnet-association-01" {
  subnet_id      = aws_subnet.ecs-subnet-01.id
  route_table_id = aws_route_table.ecs-route-table.id
}

resource "aws_route_table_association" "rtb-subnet-association-02" {
  subnet_id      = aws_subnet.ecs-subnet-02.id
  route_table_id = aws_route_table.ecs-route-table.id
}