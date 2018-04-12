variable "aws_region" {
  default = "eu-central-1"
}

variable "aws_authprofile" {
  default = "rabbitman"
}

variable "aws_ami_debian94" {
  default = "ami-ada0f946"
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
