terraform {
  source = "../../../layers//compute-remote"
}
inputs = {
  env_name = "dev1"
  region = "us-east-1"
}