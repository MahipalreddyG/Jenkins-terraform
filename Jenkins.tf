provider "aws" {
  access_key = "*********************"
  secret_key = "**********************"
  region     = "us-west-2"
}
resource "aws_instance" "jenkins" {
  ami = "ami-********"
  instance_type = "t2.micro"
  key_name="aws"
  security_groups=["launch-wizard-2"]
  tags{
    Name="jenkins"
  }
 connection {
  user = "ubuntu"
  type = "ssh"
  private_key="${file("/home/ubuntu/aws.pem")}"
  }
  provisioner "file" {
    source      = "/home/ubuntu/terraform/script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
       ]
  }
}
