resource "kafka_topic" "poc" {
  name               = "poc-topic-dev"
  partitions         = 3
  replication_factor = 2

  config = {
    "cleanup.policy" = "delete"
  }
}