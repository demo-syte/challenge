resource "aws_key_pair" "key" {

  key_name   = "key"
  public_key = file(var.Public_key_path)

}