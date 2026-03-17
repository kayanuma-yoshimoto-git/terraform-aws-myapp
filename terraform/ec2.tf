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

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-frontend-profile"
  role = aws_iam_role.ec2_role.name
}