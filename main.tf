provider "aws" {
  region = "${var.region}"
}

resource "aws_ecs_cluster" "kamilos" {
  name = "${var.tag_name}"
}


resource "aws_ecs_task_definition" "kamilos" {
  family = "${var.tag_name}"

  container_definitions = "${file("task_definition.json")}"
}

resource "aws_ecs_service" "kamilos" {
    name = "${var.tag_name}"
    cluster = "${aws_ecs_cluster.kamilos.id}"
    task_definition = "${aws_ecs_task_definition.kamilos.family}"
    desired_count = "${var.desired_count}"
}

data "template_file" "init" {
  template = "${file("copy-ecs-config-to-s3.tpl")}"
}

resource "aws_instance" "kamilos" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  user_data     = "${data.template_file.init.rendered}"

  vpc_security_group_ids = ["${aws_security_group.kamilos.id}"]
  iam_instance_profile   = "${var.iam_instance_profile}"
  key_name               = "${var.key_name}"

  tags = {
    Name = "${var.tag_name}"
  }
}

resource "aws_security_group" "kamilos" {
  name = "${var.tag_name}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ipv4}"]
  }

  tags {
    Name = "${var.tag_name}"
  }
}
