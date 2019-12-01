terraform {
  backend "s3" {
    bucket = "cfterraformtest123"
    key    = "security/main-service/dev"
    region = "us-west-2"
  }
}