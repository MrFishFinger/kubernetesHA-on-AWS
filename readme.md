# QUICKSTART

**0. ensure there is an IAM role configured in AWS**
  create IAM role named `aaa_kubernetes_role` that has adequate ec2 permissions (eg `AmazonEC2FullAccess`)


**1. install boto and configure aws credentials**

`sudo apt install python-pip && sudo pip install -U boto`

**2. populate AWS profile credentials here:** `~/.aws/credentials`

*example:*
```
[superman]
aws_secret_access_key = REDACTED
aws_access_key_id = REDACTED
```

**3. clone repo**

`git clone git@bitbucket.org:influentialchicken/kubernetes-automation.git`

**4. download terraform binary **

```
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip 
chmod +x terraform
./terraform version
```

**5. create ssh-key**
```
cd kubernetes-automation/ssh-keypairs
ssh-keygen -f kubernetes_test_key -N ''
chmod 0400 kubernetes_test_key*
```

**6. if necessary, update terraform/ec2 variables (such as region)**

`kubernetes-automation/terraform/variables.tf`
`kubernetes-automation/ansible/hosts/ec2.ini`


**7. build infrastructure:**

```
cd kubernetes-automation/ansible
AWS_PROFILE=superman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml
```
