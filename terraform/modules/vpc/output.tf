output "vpc_id" {
  value = aws_vpc.vpc_network.id
}

output "private_subnet-1_id" {
  value = aws_subnet.private_subnet-1.id
}

output "public_subnet-1_id" {
  value = aws_subnet.public_subnet-1.id
}
