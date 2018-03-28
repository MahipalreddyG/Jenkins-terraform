provider "aws" {
  access_key = "*********************"
  secret_key = "**********************"
  region     = "us-west-2"
}
# Launching AWS instance

resource "aws_instance" "jenkins" {
  ami = "ami-********"
  instance_type = "t2.micro"
  key_name="aws"
  security_groups=["launch-wizard-2"]
  tags{
    Name="jenkins"
  }
# Copy the pem key from remote machine to local machine
  
 connection {
  user = "ubuntu"
  type = "ssh"
  private_key="${file("/home/ubuntu/aws.pem")}"
  }
# Copy the script.sh file from remote machine to local machine for installing Java and Jenkins
  
  provisioner "file" {
    source      = "/home/ubuntu/terraform/script.sh"
    destination = "/tmp/script.sh"
  }
# Give the execute permissions and run the sctipt.sh
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
       ]
  }
}
