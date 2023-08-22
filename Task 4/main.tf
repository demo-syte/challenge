resource "aws_vpc" "blogapp_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "blogapp_subnet" {
  vpc_id                  = aws_vpc.blogapp_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
}

resource "aws_security_group" "blogapp_sg" {
  name        = "blogapp_security_group"
  description = "Security group for BlogApp instances"

  vpc_id = aws_vpc.blogapp_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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


#Auto Scaling group and launch configuration:


resource "aws_launch_configuration" "blogapp_lc" {
  name_prefix   = "blogapp_lc_"
  image_id      = "ami-xxxxxxxx"  # Replace with your desired AMI ID
  instance_type = "t2.micro"

  security_groups = [aws_security_group.blogapp_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "blogapp_asg" {
  name                 = "blogapp_asg"
  launch_configuration = aws_launch_configuration.blogapp_lc.name
  min_size             = 2
  max_size             = 10
  desired_capacity     = 2
  vpc_zone_identifier  = [aws_subnet.blogapp_subnet.id]

  tag {
    key                 = "Name"
    value               = "BlogAppInstance"
   
  }
}


#Create an Elastic Load Balancer (ELB):
resource "aws_elb" "blogapp_elb" {
  name               = "blogapp_elb"
  security_groups    = [aws_security_group.blogapp_sg.id]
  subnets            = [aws_subnet.blogapp_subnet.id]
  cross_zone_load_balancing   = true

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 3000
    lb_protocol       = "http"
  }

  health_check {
    target             = "HTTP:80/"
    interval           = 30
    timeout            = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}