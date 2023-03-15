
resource "random_id" "vpc_display_id" {
    byte_length = 4
}
# ------------------------------------------------------
# VPC
# ------------------------------------------------------
resource "aws_vpc" "main" { 
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "cflt-demo-${random_id.vpc_display_id.hex}"
    }
}

# ------------------------------------------------------
# SUBNETS
# ------------------------------------------------------

resource "aws_subnet" "public_subnets" {
    count = 3
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.${count.index+1}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "cflt-demo-${count.index}-${random_id.vpc_display_id.hex}"
    }
}
# ------------------------------------------------------
# IGW
# ------------------------------------------------------
resource "aws_internet_gateway" "igw" { 
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "cflt-demo-${random_id.vpc_display_id.hex}"
    }
}
# ------------------------------------------------------
# ROUTE TABLE
# ------------------------------------------------------
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "cflt-demo-${random_id.vpc_display_id.hex}"
    }
}
resource "aws_route_table_association" "subnet_associations" {
    count = 3
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.route_table.id
}


# Accepter's side of the connection.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_peering_connection
data "aws_vpc_peering_connection" "accepter" {
  vpc_id      = confluent_network.peering.aws[0].vpc
  peer_vpc_id = confluent_peering.aws.aws[0].vpc
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = data.aws_vpc_peering_connection.accepter.id
  auto_accept               = true
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.route_table.id
  destination_cidr_block    = confluent_network.peering.cidr
  vpc_peering_connection_id = data.aws_vpc_peering_connection.accepter.id
}
