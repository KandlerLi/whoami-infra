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

resource "aws_cloudwatch_log_group" "whoami_api" {
  name = "whoami_api"
}


resource "aws_ecs_task_definition" "whoami_api" {
  family                   = "whoami_api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_iam_role.arn
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "whoami_api"
      image     = "${aws_ecr_repository.kandlerli.repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.whoami_api.name,
          "awslogs-region"        = "eu-central-1",
          "awslogs-stream-prefix" = "whoami_api-logs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "whoami_api_fargate" {
  name            = "whoami_api"
  cluster         = aws_ecs_cluster.whoami.id
  task_definition = aws_ecs_task_definition.whoami_api.arn
  desired_count   = 1
}
