output "vpc-id" {
    value = aws_vpc.ec2-vpc.id
}
output "public-subnet-1a-id" {
  value = aws_subnet.public-subnet-1a.id
}
output "public-subnet-1b-id" {
  value = aws_subnet.public-subnet-1b.id
}
output "private-subnet-1a-id" {
  value = aws_subnet.private-subnet-1a.id
}
output "private-subnet-1b-id" {
  value = aws_subnet.private-subnet-1b.id
}
