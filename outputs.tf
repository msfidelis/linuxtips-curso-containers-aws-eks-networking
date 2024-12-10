output "vpc_id" {
  description = "SSM Parameter com o valor do vpc_id"
  value       = aws_ssm_parameter.vpc.id
}

output "public_subnets" {
  description = "SSM Parameters com os valores dos ID's das Subnets Públicas"
  value       = aws_ssm_parameter.public_subnets[*].id
}

output "private_subnets" {
  description = "SSM Parameters com os valores dos ID's das Subnets Privadas"
  value       = aws_ssm_parameter.private_subnets[*].id
}

output "database_subnets" {
  description = "SSM Parameters com os valores dos ID's das Subnets de Databases"
  value       = aws_ssm_parameter.databases_subnets[*].id
}