#instance 1

resource "aws_instance" "aws_instance_1" {
  ami           = "ami-06067086cf86c58e6"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id     = aws_subnet.subnet1.id
  key_name     = aws_key_pair.key_pair1.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]

  tags = {
    Name = "requester-instance1"
  }
  
}


resource "aws_key_pair" "key_pair1" {
  key_name   = "terraform-key1"
  public_key = file("terraform-key.pub")
  }




resource "aws_security_group" "sg1" {
  name        = "requester-sg1"
  description = "Security group for requester instance"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}







#instance 2

resource "aws_instance" "aws_instance_2" {
  ami           = "ami-06067086cf86c58e6"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id     = aws_subnet.subnet2.id
  key_name     = aws_key_pair.key_pair2.key_name
  vpc_security_group_ids = [aws_security_group.sg2.id]

  tags = {
    Name = "accepter-instance2"
  }
  
}



resource "aws_key_pair" "key_pair2" {
  key_name   = "terraform-key2"
  public_key = file("terraform-key2.pub")
  }


resource "aws_security_group" "sg2" {
  name        = "accepter-sg2"
  description = "Security group for accepter instance"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
