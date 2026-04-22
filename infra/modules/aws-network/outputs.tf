output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.multi_cloud.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value = [
    aws_subnet.public_subnetA.id,
    aws_subnet.public_subnetB.id
  ]
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value = [
    aws_subnet.private_subnetA.id,
    aws_subnet.private_subnetB.id
  ]
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.mc_igw.id
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = aws_nat_gateway.mcloud_nat.id
}
