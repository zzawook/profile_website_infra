build {
  name    = "aws"
  sources = ["source.amazon-ebs.ubuntu-instance"]

  provisioner "file" {
    source      = ".credentials/credentials"
    destination = "/tmp/credentials"
  }

  provisioner "file" {
    source      = ".credentials/config"
    destination = "/tmp/config"
  }

  provisioner "shell" {
    inline = ["sudo mkdir /root/.aws"]
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/credentials /root/.aws/credentials"]
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/config /root/.aws/config"]
  }

  provisioner "file" {
    source      = "./scripts/instance_start.sh"
    destination = "/tmp/instance_start.sh"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/instance_start.sh /var/tmp/instart_start.sh"]
  }

  provisioner "shell" {
    inline = ["crontab -l | { cat; echo \"0 2 * * * /var/tmp/instance_start.sh\"; } | crontab -"]
  }

  // Install Docker and Git
  provisioner "shell" {
    scripts = [
      "./scripts/install-packages.sh",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  //TODO: WRITE START CONFIGS
}