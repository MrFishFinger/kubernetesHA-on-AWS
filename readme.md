# QUICKSTART

**0. install latest version of ansible**


**1. install boto**

`sudo apt install python-pip && sudo pip install -U boto`


**2. populate AWS profile credentials here:** `~/.aws/credentials`

(ensure associated account has adequate permissions in AWS)

*example:*
```
[superman]
aws_secret_access_key = REDACTED
aws_access_key_id = REDACTED
```


**3. clone repo**

`git clone git@github.com:MrFishFinger/kubernetesHA-on-AWS.git`


**4. download terraform binary and init project**

```
cd kubernetesHA-on-AWS/terraform/
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
chmod +x terraform
./terraform version
./terraform init
```


**5. create ssh-key**
```
cd kubernetesHA-on-AWS/ssh-keypairs
ssh-keygen -f kubernetes_test_key -N ''
chmod 0400 kubernetes_test_key*
```


**6. if necessary, update terraform/ec2 variables (such as region, subnet, AZ)**

```
kubernetesHA-on-AWS/terraform/variables.tf
kubernetesHA-on-AWS/ansible/hosts/ec2.ini
```

**7. build infrastructure:**

```
cd kubernetesHA-on-AWS/ansible
AWS_PROFILE=superman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml
```
