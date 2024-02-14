resource "aws_ecr_repository" "kandlerli" {
  name                 = "kandlerli"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

moved {
  from = aws_ecr_repository.foo
  to   = aws_ecr_repository.kandlerli
}
