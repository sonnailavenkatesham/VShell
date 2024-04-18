resource "aws_instance" "name" {
  count           = length(var.instance_names)
  ami             = "ami-0f3c7d07486cad139"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.name.name]
  tags = {
    Name = var.instance_names[count.index]
  }
}

resource "aws_instance" "ansible" {
  ami             = "ami-0f3c7d07486cad139"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.name.name]
  user_data       = file("ansible.sh")
  tags = {
    Name = "Ansible"
  }
}

resource "aws_route53_record" "record" {
  count   = length(var.instance_names)
  zone_id = "Z0997824248HW2XYA9N5U"
  name    = "${var.instance_names[count.index]}.venkateshamsonnalia143.online"
  type    = "A"
  ttl     = 1
  records = [aws_instance.name[count.index].public_ip]
}