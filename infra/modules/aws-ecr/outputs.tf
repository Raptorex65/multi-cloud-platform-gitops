output "repository_urls" {
    value = {
        for repo, r in aws_ecr_repository.mc :
        repo => r.repository_url 
    }
}

### Alternative ##########
# output "repository_names" {
#   value = keys(aws_ecr_repository.mc)
# }