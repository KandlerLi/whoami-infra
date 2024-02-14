resource "aws_ecs_cluster" "whoami" {
  name = "whoami"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.whoami_ecs.name
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "whoami_ecs" {
  name = "whoami_ecs"
}
