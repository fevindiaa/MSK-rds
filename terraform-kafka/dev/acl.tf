resource "kafka_acl" "poc" {
  resource_name        = kafka_topic.poc.name
  resource_type        = "Topic"
  acl_principal        = "User:CN=client-app"
  acl_host             = "*"
  acl_operation        = "Read"
  acl_permission_type  = "Allow"
}