resource "aws_instance" "instance" {
  ami           = "ami-0d62a5f1884612d53"
  instance_type = "t2.micro"

  tags = {
    Name = "Nareninstance1"
  }
}
resource "aws_lb_target_group" "tg" {
  name     = "narendratargetgroup1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0d37b417e94050203"

    health_check {
    enabled = true
    path = "/"
    port = "80"
    protocol = "HTTP"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 10
    timeout = 5
    matcher = "200"
  }
}
resource "aws_lb_target_group_attachment" "tga" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.instance.id
  port             = 80
}
resource "aws_lb" "albnaren" {
  name               = "backend-lb"
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = 10
  subnets            = [ "subnet-0e71fac387a0940c1", "subnet-03c5543a298b20196" ]
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.albnaren.arn
    port              = "80"
    protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
}
