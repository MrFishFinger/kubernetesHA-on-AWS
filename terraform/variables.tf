variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_AZ" {
  default = "eu-central-1a"
}

variable "aws_VPC_ID" {
  default = "vpc-c56c9bad"
}

variable "aws_subnet_CIDR" {
  default = "172.31.101.0/24"
}

variable "aws_authprofile" {
  default = "superman"
}

variable "aws_ami_debian94" {
  default = "ami-b693ca5d"
}

variable "ssh_keypair_name" {
  default = "kubernetes_test_key"
}

variable "ssh_public_key_path" {
  default = "../ssh-keypairs/kubernetes_test_key.pub"
}

variable "ssh_private_key_path" {
  default = "../ssh-keypairs/kubernetes_test_key"
}
