provider "aws" {
  region = "us-east-1" 
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "ec2instanceconnectVPC" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ec2instanceconnectVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" 
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.ec2instanceconnectVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "InstanceConnectProfile" {
  name = "InstanceConnectProfile"
  role = aws_iam_role.instanceconnectrole.id
}

resource "aws_iam_role" "instanceconnectrole" {
  name = "instanceconnectrole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "instancepolicy" {
  role       = aws_iam_role.instanceconnectrole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_instance" "InstanceconnectEC2" {
  ami             = "ami-0440d3b780d96b29d" 
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile = aws_iam_instance_profile.InstanceConnectProfile.name

  tags = {
    Name = "EC2instance"
  }
}

resource "aws_ec2_instance_connect_endpoint" "connectendpoint" {
  subnet_id = aws_subnet.private_subnet.id
}

