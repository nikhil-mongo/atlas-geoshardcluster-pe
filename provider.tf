provider "mongodbatlas" {
  public_key = ""
  private_key = ""
}
provider "aws" {
  alias      = "zone1"
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}
provider "aws"{
  alias      = ""
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}