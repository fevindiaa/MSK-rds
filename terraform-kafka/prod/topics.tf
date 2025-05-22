resource "kafka_topic" "poc" {
  name               = "poc-topic-prod"
  partitions         = 3
  replication_factor = 2

  config = {
    "cleanup.policy" = "delete"
  }
}