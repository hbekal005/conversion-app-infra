# Using Data Source to get the available zones in the region
data "aws_availability_zones" "available-zones" {
  state = "available-zones"
}

# Creating a VPC
resource "aws_vpc" "conversion-app-vpc" {
  cidr_block       = lookup(var, "${terraform.workspace}_vpc_cidr_block")
  instance_tenancy = "default"

  tags = {
    Name = "${terraform.workspace}-conversion-app-vpc"
  }
}

# Create Subnets for VPC

# The count parameter is used to create multiple subnets
# The cidrsubnet function is used to calculate the CIDR block for each subnet
# The availability_zone parameter is used to specify the availability zone for each subnet
resource "aws_subnet" "ecs-subnet-01" {
  count = var.subnet_count
  vpc_id     = aws_vpc.conversion-app-vpc.id
  cidr_block = cidrsubnet(lookup(var, "${terraform.workspace}_vpc_cidr_block"), var.subnet_mask, count.index)
  availability_zone = data.aws_availability_zones.available-zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "ecs-subnet-${count.index}"
  }
}

resource "aws_subnet" "ecs-subnet-02" {
  count = var.subnet_count
  vpc_id     = aws_vpc.conversion-app-vpc.id
  cidr_block = cidrsubnet(lookup(var, "${terraform.workspace}_vpc_cidr_block"), var.subnet_mask, count.index + 1)
  availability_zone = data.aws_availability_zones.available-zones.names[count.index + 1]
  map_customer_owned_ip_on_launch = true
  tags = {
    Name = "ecs-subnet-${count.index + 1}"
  }
}

# Creating an internet gateway
resource "aws_internet_gateway" "conversion-app-igw" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "${terraform.workspace}-conversion-app-igw"
  }
}

# Creating a route table
resource "aws_route_table" "ecs-route-table" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "${terraform.workspace}-ecs-route-table"
  }
}

# Associating the route table with the subnet
resource "aws_route_table_association" "rtb-association-01" {
  subnet_id = aws_subnet.ecs-subnet-01.id
  route_table_id  = aws_route_table.ecs-route-table.id
}

# Associating the route table with the subnet
resource "aws_route_table_association" "rtb-association-02" {
  subnet_id = aws_subnet.ecs-subnet-02.id
  route_table_id  = aws_route_table.ecs-route-table.id
}