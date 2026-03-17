resource "aws_security_group" "frontend_sg" {

  name = "frontend-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "frontend" {

  ami           = "ami-xxxxxxxx"
  instance_type = "t3.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [
    aws_security_group.frontend_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "myapp-frontend"
  }

}