build {
  name    = "aws"
  sources = ["source.amazon-ebs.ubuntu-instance"]

  provisioner "file" {
    source      = "${path.root}/../.credentials/credentials"
    destination = "/home/ubuntu/.aws/credentials"
  }

  provisioner "file" {
    source      = "${path.root}/../.credentials/config"
    destination = "/home/ubuntu/.aws/config"
  }

  provisioner "file" {
    source      = "${path.root}/startup_playbook.service"
    destination = "/tmp/startup_playbook.service"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/startup_playbook.service /etc/systemd/system/startup_playbook.service"]
  }

  provisioner "file" {
    #Path to your own AWS config file
    source      = "${path.root}/playbooks/startup_playbook.yml"
    destination = "/home/ubuntu/startup_playbook.yml"
  }

  provisioner "ansible" {
      playbook_file = "./playbooks/ami_playbook.yml"
    }

//   provisioner "shell" {
//     inline = [
//       "echo MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD} >> /etc/environment",
//       "echo MYSQL_USER=${var.MYSQL_USER} >> /etc/environment",
//       "echo MYSQL_PASSWORD=${var.MYSQL_PASSWORD} >> /etc/environment",
//       "echo MYSQL_DATABASE=${var.MYSQL_DATABASE} >> /etc/environment"
//     ]
//     execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
//   }
}