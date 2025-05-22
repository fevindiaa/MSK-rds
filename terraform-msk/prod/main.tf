provider "aws" {
  region = "eu-north-1"
}

resource "aws_msk_cluster" "tls_msk" {
  cluster_name           = "tls-msk-cluster-${var.env}"
  kafka_version          = "3.6.0"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type   = "kafka.m5.large"
    client_subnets  = var.client_subnets
    security_groups = [aws_security_group.msk_sg.id]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  client_authentication {
    tls {
      enabled = true
    }
  }

  tags = {
    Environment = var.env
    Name        = "tls-msk-cluster-${var.env}"
  }
}

resource "aws_security_group" "msk_sg" {
  name   = "msk-tls-sg-${var.env}"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}