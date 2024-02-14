resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.default.id
}


########################################################################################################################
## SG for ECS Container Instances
########################################################################################################################

resource "aws_security_group" "ecs_container_instance" {
  name        = "sg_whoami_ecs"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = aws_vpc.default.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP only"
    from_port       = 4200
    to_port         = 4200
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

########################################################################################################################
## SG for ALB
########################################################################################################################

resource "aws_security_group" "alb" {
  name        = "sg_whoami_alb"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.default.id

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
