terraform {
  backend "s3" {
    bucket         = "mybucketfortfstate22"
    key            = "state/tf_current.tfstate"
    region         = "us-east-2"
    dynamodb_table = "remote-backend22"
  }
}