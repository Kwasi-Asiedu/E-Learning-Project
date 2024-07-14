output "vpc_id" {
  value       = aws_vpc.dt_vpc.id
  description = "outputs ID of vpc"
}

output "public_subnets" {
  description = "outputs public subnets"
  value       = [aws_subnet.public_subnets[0], aws_subnet.public_subnets[1]]
}

output "private_subnets" {
  description = "outputs private subnets"
  value       = [aws_subnet.private_subnets[0], aws_subnet.private_subnets[1]]
}

output "cidr_block" {
  description = "outputs CIDR block of vpc"
  value       = aws_vpc.dt_vpc.cidr_block
}