
resource "aws_eip" "this" {}

module "defaults" {
  source            = "../.."
  keystore_password = "testing1."
  keystore_path     = "${path.cwd}/../../testing/fixtures/keystore"
  main_ip           = aws_eip.this.public_ip
  network_name      = "testnet"
  private_key_path  = var.private_key_path
  public_key_path   = var.public_key_path
}

variable "private_key_path" {}
variable "public_key_path" {}
