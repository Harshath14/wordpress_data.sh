provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "wordpress-sg6" {
  name        = "wordpress-sg6"
  description = "Allow HTTP, HTTPS, SSH, and MySQL traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
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

# Create an EC2 instance for WordPress
resource "aws_instance" "wordpress" {
  ami           = "ami-043a5a82b6cf98947"
  instance_type = "t2.micro"
  key_name      = "aws2"              
  subnet_id     = "subnet-08f0e7d824c801144"            
  security_groups = [aws_security_group.wordpress-sg6.id]

  user_data = file("data.sh")            

  tags = {
    Name = "Public Instance"
  }
}
