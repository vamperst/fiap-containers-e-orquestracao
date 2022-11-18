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
  provisioner "file" {
    source      = "docker_ecr_login.service"
    destination = "/tmp/docker_ecr_login.service"
  }
  provisioner "file" {
    source      = "ecr-login.sh"
    destination = "/tmp/ecr-login.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo cp /tmp/ecr-login.sh /etc/systemd/system/ecr-login.sh",
      "sudo cp /tmp/docker_ecr_login.service /etc/systemd/system/docker_ecr_login.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable docker_ecr_login",
      "sudo systemctl start docker_ecr_login",
      "sudo systemctl status docker_ecr_login"

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
