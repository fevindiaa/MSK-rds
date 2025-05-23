variable "client_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "env" {
  type = string
}
variable "ca_arn" {
  description = "ARN of the ACM Private CA used for MSK TLS client authentication"
  type        = string
}
