provider "aws" {
  region = "eu-north-1"
}

resource "aws_msk_cluster" "main" {
  cluster_name           = "fev-msk-cluster"
  kafka_version          = "3.6.0"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
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
      certificate_authority_arns = [var.ca_arn]
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled         = true
        log_group       = aws_cloudwatch_log_group.msk_logs.name
      }
    }
  }

  tags = {
    Environment = var.env
    Name        = "fev-msk-cluster"
  }
}

resource "aws_security_group" "msk_sg" {
  name        = "msk-sg-${var.env}"
  description = "Security group for MSK cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "msk_logs" {
  name              = "/aws/msk/${var.env}/broker"
  retention_in_days = 14
}


