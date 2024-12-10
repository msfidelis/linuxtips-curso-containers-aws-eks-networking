output "vpc_id" {
  value = aws_ssm_parameter.vpc.id
}

output "public_subnets" {
  value = aws_ssm_parameter.public_subnets[*].id
}

output "private_subnets" {
  value = aws_ssm_parameter.private_subnets[*].id
}

output "database_subnets" {
  value = aws_ssm_parameter.databases_subnets[*].id
}