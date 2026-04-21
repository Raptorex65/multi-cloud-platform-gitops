variable "repository_names" {
    description = "ECR repository names"
    type = list(string)
}
variable "tags" {
  type = map(string)
}
