resource "aws_ecr_repository" "repo" {
    name = "hybrid-devsecops-etb101"

    image_scanning_configuration {
        scan_on_push = true
    }
}