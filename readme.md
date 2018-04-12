# README

**QUICKSTART**

1. This is a numbered list.
2. I'm going to include a fenced code block as part of this bullet:

    ```
    Code
    More Code
    ```

- install boto and configure aws credentials
-- `sudo apt install python-pip && sudo pip install -U boto`
-- populate AWS profile credentials here: `~/.aws/credentials` - example below:
    ```
    [rabbitman]
    aws_secret_access_key = REDACTED
    aws_access_key_id = REDACTED
    ```

 - clone repo
`git clone git@bitbucket.org:influentialchicken/kubernetes-automation.git`

 - create ssh-key
`cd kubernetes-automation/ssh-keypairs`
`ssh-keygen -f kubernetes_test_key -N ''`

- update terraform variables if necessary
`kubernetes-automation/terraform/variables.tf`


 - build infrastructure:
`cd kubernetes-automation/ansible`
`AWS_PROFILE=rabbitman ansible-playbook playbooks/playbook-build-kubernetes-cluster.yml`
