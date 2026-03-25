# セキュリティグループ
resource "aws_security_group" "frontend_sg" {
  name   = "frontend-sg"
  vpc_id = aws_vpc.main.id  # ← 追加

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ← とりあえず（後で制限推奨）
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# インスタンスプロファイル
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}
# EC2 本体
resource "aws_instance" "frontend" {
  ami           = "ami-0599b6e53ca798bb2"
  instance_type = "t3.micro"

  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  associate_public_ip_address = true

  # 初回起動時のセットアップ
  user_data = <<-EOF
    #!/bin/bash
    # Node.js 20 インストール
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
    yum install -y nodejs

    # pm2 インストール
    npm install -g pm2

    # SSM Agent 起動
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent

    # S3 から初回資材取得
    aws s3 cp s3://myapp-artifact-kayanuma/dev/app.tar.gz /home/ec2-user/app.tar.gz
    cd /home/ec2-user && tar -xzf app.tar.gz

    # Next.js ビルド & 起動
    cd /home/ec2-user/next-learning-project
    pm2 start npm --name next -- start
    pm2 save
    pm2 startup systemd -u ec2-user --hp /home/ec2-user
  EOF

  tags = {
    Name = "myapp-frontend"
  }
}