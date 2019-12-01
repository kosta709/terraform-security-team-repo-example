terraform {
  backend "s3" {
    bucket = "cfterraformtest123"
    key    = "security/main-service/test-1"
    region = "us-west-2"
  }
}