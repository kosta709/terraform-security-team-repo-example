provider "aws" {
  region = var.aws_region
  version = "~> 2.0"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    terraform = "true"
    environment = var.environment
    service = var.service_name
  }
}

data "aws_vpc" "vpc" {
  tags = var.vpc_tags_selector
}

resource "aws_security_group" "public_sg" {
  vpc_id = data.aws_vpc.vpc.id
  name = var.public_sg_name

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.public_sg_allow_ports_rules 
    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol  = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = merge(
    {"Name" = var.public_sg_name},
    local.common_tags
  )
}

resource "aws_security_group" "private_sg" {
  vpc_id = data.aws_vpc.vpc.id
  name = var.private_sg_name

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.private_sg_allow_ports_rules 
    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol  = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = merge(
    {"Name" = var.private_sg_name},
    local.common_tags
  )
}



# resource "aws_security_group_rule" "private_sg_rules_ports" {
#   count = length(var.allow_ports_rules)
#   security_group_id = data.aws_security_groups.private_sg.ids[0]

#   type            = "ingress"
#   description     = var.allow_ports_rules[count.index].description
#   from_port       = var.allow_ports_rules[count.index].from_port
#   to_port         = var.allow_ports_rules[count.index].to_port
#   protocol        = var.allow_ports_rules[count.index].protocol
#   cidr_blocks     = var.allow_ports_rules[count.index].cidr_blocks

# }