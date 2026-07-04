resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  vpc_id        = aws_vpc.vpc1.id
  peer_vpc_id   = aws_vpc.vpc2.id
  auto_accept   = true
  tags = {
    Name = "vpc-peering-connection"
  }
  
}