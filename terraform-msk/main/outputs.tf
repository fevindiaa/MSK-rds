output "bootstrap_server" {
  value       = aws_msk_cluster.main.bootstrap_brokers_tls
  description = "MSK TLS bootstrap servers"
}


