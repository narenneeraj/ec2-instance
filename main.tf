resource "aws_instance" "instance" {
  ami           = "ami-0d62a5f1884612d53"
  instance_type = "t2.micro"

  tags = {
    Name = "Nareninstance1004"
  }
}
