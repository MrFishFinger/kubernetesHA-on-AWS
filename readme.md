# QUICKSTART

**1. install boto and configure aws credentials**

`sudo apt install python-pip && sudo pip install -U boto`

**2. populate AWS profile credentials here:** `~/.aws/credentials`

*example:*
```
[rabbitman]
aws_secret_access_key = REDACTED
aws_access_key_id = REDACTED
```

**3. clone repo**

`git clone git@bitbucket.org:influentialchicken/kubernetes-automation.git`

**4. create ssh-key**
```
cd kubernetes-automation/ssh-keypairs
ssh-keygen -f kubernetes_test_key -N ''
```

**5. update terraform variables, if necessary**

`kubernetes-automation/terraform/variables.tf`


**6. build infrastructure:**

```
cd kubernetes-automation/ansible
AWS_PROFILE=rabbitman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml
```
