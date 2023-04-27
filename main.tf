provider "aws" {
  region = "us-west-2" # Change to your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Change to your desired AMI ID
  instance_type = "t2.micro" # Change to your desired instance type
  key_name      = "my-key-pair" # Change to your desired key pair name

  # Add a security group to allow inbound SSH traffic from anywhere
  vpc_security_group_ids = [aws_security_group.example.id]

  # Use an Amazon Linux 2 AMI with the latest version of the SSM agent
  # to enable remote management through the AWS Systems Manager
  # (optional, but highly recommended)
  user_data = <<EOF
              #!/bin/bash
              amazon-linux-extras install -y epel
              yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = "example-instance"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-sg-"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
