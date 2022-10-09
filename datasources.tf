data "aws_ami" "server_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "template_file" "ec2_script" {
  template = file("userdata.tpl")
  vars= {
    access_key_id = var.aws_access_key_id
    secret_access_key = var.aws_secret_access_key
  }
}
