provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_authprofile}"
}


resource "aws_iam_role" "kubernetes_full_ec2_role" {
    name = "kubernetes_full_ec2_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "kubernetes_full_ec2_role" {
  name  = "kubernetes_full_ec2_role"
  role = "${aws_iam_role.kubernetes_full_ec2_role.id}"
}


resource "aws_iam_role_policy_attachment" "kubernetes_full_ec2_role_attach" {
    role       = "${aws_iam_role.kubernetes_full_ec2_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


resource "aws_key_pair" "kubernetes_keypair1" {
  key_name   = "${var.ssh_keypair_name}"
  public_key = "${file(var.ssh_public_key_path)}"
}


resource "aws_subnet" "kubernetes_subnet" {
  vpc_id                  = "${var.aws_VPC_ID}"
  cidr_block              = "${var.aws_subnet_CIDR}"
  availability_zone       = "${var.aws_AZ}"
  map_public_ip_on_launch = true
  tags {
    Name = "kubernetes_subnet"
  }
}


resource "aws_security_group" "kubernetes_security_group" {
  name = "kubernetes1"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "worldwide inbound SSH access"
    description = "worldwide inbound ICMP access"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "inter-SG access"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "worldwide outbound access"
  }
}


resource "aws_instance" "kube-master0" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"


  connection {
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-master0"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-master1" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-master1"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-master2" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"

  connection {
    type         = "ssh"
    user         = "admin"
    private_key  = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-master2"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-node0" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-node0"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-node1" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-node1"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-node2" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_AZ}"
  subnet_id              = "${aws_subnet.kubernetes_subnet.id}"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_security_group.id}"]
  iam_instance_profile   = "${aws_iam_role.kubernetes_full_ec2_role.id}"

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  tags {
    "Name"                             = "kube-node2"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}

########### Modern NLB problematic with port 6443/tcp. Currently using Classic LB instead ###########
# resource "aws_lb" "kubernetesAPI-internal-lb1" {
#   name               = "kubernetesAPI-internal-lb1"
#   load_balancer_type = "network"
#   internal           = true
#   subnets            = ["${aws_subnet.kubernetes_subnet.id}"]
# }
#
# resource "aws_lb_target_group" "kubernetesAPI-internal-lb1" {
#   name        = "kubernetesAPI-internal-lb1"
#   port        = 6443
#   protocol    = "TCP"
#   target_type = "instance"
#   vpc_id      = "${var.aws_VPC_ID}"
#   stickiness  = []
# }
#
# resource "aws_lb_listener" "kubernetesAPI-internal-lb1" {
#   load_balancer_arn = "${aws_lb.kubernetesAPI-internal-lb1.arn}"
#   port              = 6443
#   protocol          = "TCP"
#
#   default_action {
#     target_group_arn = "${aws_lb_target_group.kubernetesAPI-internal-lb1.arn}"
#     type             = "forward"
#   }
# }
#
# resource "aws_lb_target_group_attachment" "kubernetesAPI-internal-lb1_kube-master0" {
#   target_group_arn = "${aws_lb_target_group.kubernetesAPI-internal-lb1.arn}"
#   target_id        = "${aws_instance.kube-master0.id}"
#   port             = 6443
# }
#
# resource "aws_lb_target_group_attachment" "kubernetesAPI-internal-lb1_kube-master1" {
#   target_group_arn = "${aws_lb_target_group.kubernetesAPI-internal-lb1.arn}"
#   target_id        = "${aws_instance.kube-master1.id}"
#   port             = 6443
# }
#
# resource "aws_lb_target_group_attachment" "kubernetesAPI-internal-lb1_kube-master2" {
#   target_group_arn = "${aws_lb_target_group.kubernetesAPI-internal-lb1.arn}"
#   target_id        = "${aws_instance.kube-master2.id}"
#   port             = 6443
# }
########### Modern NLB problematic with port 6443/tcp. Currently using Classic LB instead ###########


resource "aws_elb" "kubernetesAPI-internal-lb1" {
  name                        = "kubernetesAPI-internal-lb1"
  internal                    = true
  subnets                     = ["${aws_subnet.kubernetes_subnet.id}"]
  security_groups             = ["${aws_security_group.kubernetes_security_group.id}"]
  instances                   = ["${aws_instance.kube-master0.id}", "${aws_instance.kube-master1.id}", "${aws_instance.kube-master2.id}"]
  cross_zone_load_balancing   = false
  idle_timeout                = 400

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "TCP:6443"
    interval            = 10
  }
}




resource "aws_ebs_volume" "test1-ebs-volume1" {
  availability_zone = "${var.aws_AZ}"
  size              = 10
  tags {
    name = "test1-ebs-volume1"
  }
}


resource "aws_efs_file_system" "test2-efs-fs1" {
  creation_token = "test2-efs-fs1"

  tags {
    name = "test2-efs-fs1"
  }
}

resource "aws_efs_mount_target" "test2-efs-fs1-mount-target" {
  file_system_id  = "${aws_efs_file_system.test2-efs-fs1.id}"
  subnet_id       = "${aws_subnet.kubernetes_subnet.id}"
  security_groups = ["${aws_security_group.kubernetes_security_group.id}"]
}


output "kubemaster0_ip" {
  value = "${aws_instance.kube-master0.public_ip}"
}

output "kubemaster1_ip" {
  value = "${aws_instance.kube-master1.public_ip}"
}

output "kubemaster2_ip" {
  value = "${aws_instance.kube-master2.public_ip}"
}

output "kubenode0_ip" {
  value = "${aws_instance.kube-node0.public_ip}"
}

output "kubenode1_ip" {
  value = "${aws_instance.kube-node1.public_ip}"
}

output "kubenode2_ip" {
  value = "${aws_instance.kube-node2.public_ip}"
}



output "test1_ebs_volume_id" {
  value = "${aws_ebs_volume.test1-ebs-volume1.id}"
}


output "test2_efs_fs_dnsname" {
  value = "${aws_efs_file_system.test2-efs-fs1.dns_name}"
}


output "kubernetes_api_internal_nlb1_dnsname" {
  value = "${aws_lb.kubernetes-api-internal-nlb1.dns_name}"
}
