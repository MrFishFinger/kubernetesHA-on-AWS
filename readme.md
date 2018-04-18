# QUICKSTART

**0. install latest version of ansible**


**1. install boto and configure aws credentials**

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

`git clone git@bitbucket.org:influentialchicken/kubernetes-automation.git`


**4. download terraform binary and init project**

```
cd kubernetes-automation/terraform/
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip terraform_0.11.7_linux_amd64.zip
chmod +x terraform
./terraform version
./terraform init
```


**5. create ssh-key**
```
cd kubernetes-automation/ssh-keypairs
ssh-keygen -f kubernetes_test_key -N ''
chmod 0400 kubernetes_test_key*
```


**6. if necessary, update terraform/ec2 variables (such as region, subnet, AZ)**

`kubernetes-automation/terraform/variables.tf`
`kubernetes-automation/ansible/hosts/ec2.ini`


**7. build infrastructure:**

```
cd kubernetes-automation/ansible
AWS_PROFILE=superman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml
```
