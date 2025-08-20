provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "my_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name

  tags = {
    Name = "terraform-sample-ec2"
  }
}

# ---- NULL RESOURCE FOR PROVISIONING ----
resource "null_resource" "provision" {
  depends_on = [aws_instance.my_ec2]

  # Remote exec: run inside the EC2 instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",   # Ubuntu/Debian
    ]

    connection {
      type        = "ssh"
      user      = "ubuntu"               # Ubuntu AMI
      private_key = file(var.pem_file)
      host        = aws_instance.my_ec2.public_ip
    }
  }

  # Local exec: run Ansible from your machine
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${aws_instance.my_ec2.public_ip},' -u ubuntu --private-key ${var.pem_file} -e 'ansible_ssh_common_args=\"-o StrictHostKeyChecking=no\"' apache-install.yml"
  }
}
