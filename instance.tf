
resource "aws_instance" "publicinst" {
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  ami = "ami-096fda3c22c1c990a"
  subnet_id = aws_subnet.nat_gateway.id
 security_groups = [aws_security_group.securitygroup.id]

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

 connection {

    host = "${self.public_ip}"
    user = "ec2-user"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"


   }
}




resource "aws_eip" "publicinst" {
  instance = aws_instance.publicinst.id
  vpc = true
}


resource "aws_instance" "PrivateInstance" {
  instance_type = "t2.micro"
  ami = "ami-096fda3c22c1c990a"
  subnet_id = aws_subnet.instance.id
  security_groups = [aws_security_group.securitygroup.id]
  key_name = aws_key_pair.mykey.key_name
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name" = "PrivateInstance"
  }
}

output "instance_private_ip" {
  value = aws_instance.PrivateInstance.private_ip
}

