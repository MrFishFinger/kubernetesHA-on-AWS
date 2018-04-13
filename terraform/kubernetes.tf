provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_authprofile}"
}


resource "aws_key_pair" "kubernetes_keypair1" {
  key_name   = "${var.ssh_keypair_name}"
  public_key = "${file(var.ssh_public_key_path)}"
}


resource "aws_security_group" "kubernetes1" {
  name = "kubernetes1"

  ingress {
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
  }

  ingress {
    from_port    = -1
    to_port      = -1
    protocol     = "icmp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "kube-master1" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes1.id}"]
  iam_instance_profile   = "${var.aws_iam_role_for_kubernetes}"

  connection {
    type         = "ssh"
    user         = "admin"
    private_key  = "${file(var.ssh_private_key_path)}"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 10",
  #     "sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y"
  #   ]
  # }

  tags {
    "Name" = "kube-master1"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}

resource "aws_instance" "kube-master2" {
  ami                    = "${var.aws_ami_debian94}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes1.id}"]
  iam_instance_profile   = "${var.aws_iam_role_for_kubernetes}"

  connection {
    type         = "ssh"
    user         = "admin"
    private_key  = "${file(var.ssh_private_key_path)}"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 10",
  #     "sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y"
  #   ]
  # }

  tags {
    "Name" = "kube-master2"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-node1" {
  ami           = "${var.aws_ami_debian94}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes1.id}"]
  iam_instance_profile   = "${var.aws_iam_role_for_kubernetes}"

  connection {
    type         = "ssh"
    user         = "admin"
    private_key  = "${file(var.ssh_private_key_path)}"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 10",
  #     "sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y"
  #   ]
  # }

  tags {
    "Name" = "kube-node1"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}


resource "aws_instance" "kube-node2" {
  ami           = "${var.aws_ami_debian94}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.kubernetes_keypair1.id}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes1.id}"]
  iam_instance_profile   = "${var.aws_iam_role_for_kubernetes}"

  connection {
    type         = "ssh"
    user         = "admin"
    private_key  = "${file(var.ssh_private_key_path)}"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 10",
  #     "sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y"
  #   ]
  # }

  tags {
    "Name" = "kube-node2"
    "kubernetes.io/cluster/kubernetes" = "owned"
  }
}




output "kubemaster1_ip" {
  value = "${aws_instance.kube-master1.public_ip}"
}

output "kubemaster2_ip" {
  value = "${aws_instance.kube-master2.public_ip}"
}

output "kubenode1_ip" {
  value = "${aws_instance.kube-node1.public_ip}"
}

output "kubenode2_ip" {
  value = "${aws_instance.kube-node2.public_ip}"
}
