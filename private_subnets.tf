resource "aws_eip" "eip" {
  count = length(var.public_subnets)

  domain = "vpc"

  tags = {
    Name = format("%s-%s", var.project_name, var.public_subnets[count.index].availability_zone)
  }
}

resource "aws_nat_gateway" "main" {

  count = length(var.public_subnets)

  allocation_id = aws_eip.eip[count.index].id

  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = format("%s-%s", var.project_name, var.public_subnets[count.index].availability_zone)
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block        = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].availability_zone

  tags = {
    Name = var.private_subnets[count.index].name
  }

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.main
  ]
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("%s-%s", var.project_name, var.private_subnets[count.index].name)
  }
}


resource "aws_route" "private" {
  count = length(var.private_subnets)

  destination_cidr_block = "0.0.0.0/0"

  route_table_id = aws_route_table.private[count.index].id

  gateway_id = aws_nat_gateway.main[
    index(
      var.public_subnets[*].availability_zone,
      var.private_subnets[count.index].availability_zone
    )
  ].id

}


resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}