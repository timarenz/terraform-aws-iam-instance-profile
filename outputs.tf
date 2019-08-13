output "role_id" {
  value = aws_iam_role.main.id
}

output "role_name" {
  value = aws_iam_role.main.name
}

output "instance_profile_id" {
  value = aws_iam_instance_profile.main.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.main.name
}

