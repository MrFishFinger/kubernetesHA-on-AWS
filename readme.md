# QUICKSTART

</br></br>**1. install boto and configure aws credentials**

`sudo apt install python-pip && sudo pip install -U boto`

</br></br>**2. populate AWS profile credentials here:** `~/.aws/credentials`

*example:*
```
[rabbitman]
aws_secret_access_key = REDACTED
aws_access_key_id = REDACTED
```

</br></br>**3. clone repo**

`git clone git@bitbucket.org:influentialchicken/kubernetes-automation.git`

</br></br>**4. create ssh-key**
```
cd kubernetes-automation/ssh-keypairs
ssh-keygen -f kubernetes_test_key -N ''
```

</br></br>**5. update terraform variables, if necessary**

`kubernetes-automation/terraform/variables.tf`


</br></br>**6. build infrastructure:**

```
cd kubernetes-automation/ansible
AWS_PROFILE=rabbitman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml
```
