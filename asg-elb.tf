resource "aws_elb" "web-elb" {
  name = "myAwesomeELB"
  security_groups = ["${aws_security_group.web-sg.id}"]
  subnets = ["${aws_subnet.public-subnet.id}", "${aws_subnet.private-subnet.id}"]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 4
    timeout             = 5
    target              = "TCP:8080"
    interval            = 30
  }
}

resource "aws_autoscaling_group" "web-asg" {
  #availability_zones   = ["eu-central-1a", "eu-central-1b"]
  vpc_zone_identifier = ["${aws_subnet.public-subnet.id}", "${aws_subnet.private-subnet.id}"]
  name                 = "myAwesomeASG"
  max_size             = "3"
  min_size             = "1"
  desired_capacity     = "2"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.web-lc.name}"
  load_balancers       = ["${aws_elb.web-elb.name}"]

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
}

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "my_keypair"
  public_key = "${file("navvis.pub")}"
}

resource "aws_launch_configuration" "web-lc" {
  name          = "myAwesomeLC"
  image_id      = "${var.ami}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  security_groups = ["${aws_security_group.web-sg.id}"]
  user_data       = "${file("userdata.sh")}"
  key_name        = "${aws_key_pair.default.id}"
}
