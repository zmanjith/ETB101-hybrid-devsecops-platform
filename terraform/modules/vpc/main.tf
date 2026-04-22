resource "aws_vpc" "main" {
    cidr_block = var.cidr_block

    tags = {
        Name = "hybrid-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
    route_table_id = aws_route_table.public.id
    gateway_id = aws_internet_gateway.igw.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)

    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id

}
data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)

    vpc_id      = aws_vpc.main.id
    cidr_block  = var.public_subnets[count.index]

    availability_zone = data.aws_availability_zones.available.names[count.index]

    map_public_ip_on_launch     = true
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)

    vpc_id      = aws_vpc.main.id
    cidr_block  = var.private_subnets[count.index]
}

