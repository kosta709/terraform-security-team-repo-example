aws_region = "us-west-2"

environment = "test-1"

vpc_tags_selector = {
  Name = "test-1-main-service"
  environment = "test-1"
  service = "main-service"
  terraform = "true"
}

public_sg_name = "test-1-main-service-public-sg"
public_sg_allow_ports_rules = [
  {
    description = "allow-http"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = [
      "85.64.0.0/16"
    ]
  },
  {
    description = "rule-1"
    from_port = "32000"
    to_port = "33000"
    protocol = "tcp"
    cidr_blocks = [
      "46.117.166.111/32",
      "172.16.0.0/12"
    ]
  },
  {
    description = "rule-2"
    from_port = "34000"
    to_port = "35000"
    protocol = "tcp"
    cidr_blocks = [
      "46.117.166.112/32",
      "10.0.0.0/12"
    ]
  },
  {
    description = "rule-3"
    from_port = "38000"
    to_port = "39000"
    protocol = "tcp"
    cidr_blocks = [
      "46.117.166.112/32",
      "10.0.0.0/12"
    ]
  }
]

private_sg_name = "test-1-main-service-private-sg"
private_sg_allow_ports_rules = [{
    description = "allow in-vpc access"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "10.100.0.0/16"
    ]
  }
]
