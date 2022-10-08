resource "aws_vpc" "my_vpc" {
  cidr_block = "10.123.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "my_subnet"
    Scope = "dev"
  }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = var.default_tags
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = var.default_tags
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  tags = var.default_tags
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.my_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "my_rt_association" {
  route_table_id = aws_route_table.my_rt.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_security_group" "my_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "my_sg"
  description = "dev security group"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "aws_tf_key"
  public_key = file("~/.ssh/aws_tf_key.pub")
}

resource "aws_instance" "my_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.my_key.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_public_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name  = "my_node",
    Scope = "dev"
  }
}
