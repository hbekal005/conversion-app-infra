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

#Creating all the public resources for the VPC

# Creating a public subnet
# The count parameter is used to create multiple subnets
# The cidrsubnet function is used to calculate the CIDR block for each subnet
# The availability_zone parameter is used to specify the availability zone for each subnet
resource "aws_subnet" "ecs-public-subnet" {
  count = var.subnet_count
  vpc_id     = aws_vpc.conversion-app-vpc.id
  cidr_block = cidrsubnet(lookup(var, "${terraform.workspace}_vpc_cidr_block"), var.subnet_mask, count.index)
  availability_zone = data.aws_availability_zones.available-zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${count.index}"
  }
}



# Creating a Public route table
resource "aws_route_table" "ecs-public-route-table" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "ecs_public_route_table"
  }
}

# Creating Public route
resource "aws_route" "ecs-public-route" {
  route_table_id         = aws_route_table.ecs-public-route-table.id
  destination_cidr_block = var.all_cidr_block
  gateway_id             = aws_internet_gateway.conversion-app-igw.id
}

# Creating an internet gateway
resource "aws_internet_gateway" "conversion-app-igw" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "conversion-app-igw"
  }
}

# Associating the public route table with the public subnet
resource "aws_route_table_association" "public-rtb-association" {
  count = var.subnet_count
  subnet_id   = aws_subnet.ecs-public-subnet[count.index].id
  route_table_id  = aws_route_table.ecs-public-route-table.id
}

# Creating an Elastic IP for the NAT gateway
resource "aws_eip" "conversion-app-eip" {
  domain   = "vpc"
}

# Creating all the private resources for the VPC
# NAT gateway is created in the public subnet but used by the private subnet
resource "aws_nat_gateway" "conversion-app-ngw" {
  allocation_id = aws_eip.conversion-app-eip.id
  subnet_id     = aws_subnet.ecs-public-subnet[0].id
  tags = {
    Name = "conversion-app-ngw"
  }
}

#Creating Private Subnet
# The count parameter is used to create multiple subnets
# The cidrsubnet function is used to calculate the CIDR block for each subnet
# The availability_zone parameter is used to specify the availability zone for each subnet
# Count.index + 2 is used to ensure that there are no overlapping CIDR blocks with the public subnets
resource "aws_subnet" "ecs-private-subnet" {
  count = var.subnet_count
  vpc_id     = aws_vpc.conversion-app-vpc.id
  cidr_block = cidrsubnet(lookup(var, "${terraform.workspace}_vpc_cidr_block"), var.subnet_mask, count.index + 2)
  tags = {
    Name = "private_subnet-${count.index}"
  }
}

# Creating a private route table
resource "aws_route_table" "ecs-private-route-table" {
  vpc_id = aws_vpc.conversion-app-vpc.id

  tags = {
    Name = "ecs_private_route_table"
  }
}

# Creating a private route
resource "aws_route" "ecs-private-route" {
  route_table_id         = aws_route_table.ecs-private-route-table.id
  destination_cidr_block = var.all_cidr_block
  gateway_id             = aws_nat_gateway.conversion-app-ngw.id
}

# Associating the private route table with the private subnet
resource "aws_route_table_association" "private-rtb-association" {
  count = var.subnet_count
  subnet_id   = aws_subnet.ecs-private-subnet[count.index].id
  route_table_id  = aws_route_table.ecs-private-route-table.id
}