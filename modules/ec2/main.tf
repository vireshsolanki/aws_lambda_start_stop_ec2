
data "aws_ami" "my-ami" {
    owners = [400060033280]
    filter {
      name = "name"
      values = ["amzn2-x86_64-MATEDE_DOTNET-2023.10.12"]
    }
     filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "key-pair" {
  key_name   = "lambdaec2"
  public_key = file("~/.ssh/lambdaec2.pub")
}

resource "aws_security_group" "security" {
  name = "allow-all"

  vpc_id = var.vpc-id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}                                                                                    

resource "aws_instance" "lambda-instance" {
    ami = data.aws_ami.my-ami.id
    instance_type = var.instance-type
    key_name = aws_key_pair.key-pair.key_name
    subnet_id = var.public-subnet-1a-id
    associate_public_ip_address = true
    security_groups =["${aws_security_group.security.id}"] 
    user_data = filebase64("../modules/ec2/userdata.sh")
    root_block_device {
      volume_size = 8
    }
    tags ={
        Name = "lambda-instance"
    }   
}
