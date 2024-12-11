terraform {
  backend "s3" {
    bucket = "tf-state-bucket-7743"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    # Specifies the prefix for the state file key in the remote backend, allowing separation of environments by workspace (e.g., "env/dev", "env/prod").
    workspace_key_prefix = "env"
  }
}
