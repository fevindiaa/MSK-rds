data "terraform_remote_state" "msk" {
  backend = "s3"
  config = {
    bucket = "your-bucket-name"
    key    = "msk/staging/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "kafka" {
  bootstrap_servers = [data.terraform_remote_state.msk.outputs.bootstrap_server]
  tls_enabled       = true
  ca_cert           = file("./certs/ca.pem")
  client_cert       = file("./certs/client.crt")
  client_key        = file("./certs/client.key")
}