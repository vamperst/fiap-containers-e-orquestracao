# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "web" {
  instance_type = "t3.micro"
  ami           = "${lookup(var.aws_amis, var.aws_region)}"
  iam_instance_profile = "LabInstanceProfile"

  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  key_name               = "${var.KEY_NAME}"

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
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_KEY}")}"
    host = "${self.public_dns}"
  }

  tags = {
    Name = "docker-swarm-manager"
  }
}
