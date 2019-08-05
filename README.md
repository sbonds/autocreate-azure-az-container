# Automated Azure ARM Powershell Controller Host Setup

Chris Neale posted [this great guide to setting up a Docker host for running Azure scripts](https://www.chrisneale.org/PowerShellAzModulesAndGitInDocker/). 
Often the hardest part for getting automation working is creating an environment where the automation works. His config works great, but perhaps it's worth
even automating that setup? Of course, this itself invites the classic chicken-and-egg problem-- if we automate that setup, how is the automation needed
for it set up?

I'm going to just dodge that question and instead assume that the following are set up and working. It's already true for me, which is why this exercise
even started.

* Docker
* Ansible

Due to that second one, this process will only work on Linux. Automating this setup could lead to a CI/CD based auto-build and auto-deploy of a new Docker
image based on changes made to the master branch.

## Running the Ansible Playbook

Since this takes place all on the local system, no Ansible inventory is needed. However, Ansible interprets a single word to the inventory argument as a file, so we force a single non-file hostname using a trailing comma>

    $ ansible-playbook -vvv -i localhost, create-azure-arm-docker-image.yaml

## Test-Driven Infrastructure

An Inspec test is present to confirm the image is set up correctly.

```output
$ cd inspec-profiles
$ inspec exec azure-arm-docker-image-check -t docker://azure-arm

Profile: Azure ARM Docker Image check (azure-arm-docker-image-check)
Version: 0.1.0
Target:  docker://a52acdfea0fc405103dc1e48e082e609e1df15750e94ff276c29eacb41412b0b

  ✔  git-installed: Check that Git is installed
     ✔  System Package git should be installed
  ✔  powershell-installed: Check that PowerShell Core is installed
     ✔  System Package powershell should be installed
  ✔  AZ-module-installed: Check that the PowerShell AZ module is installed
     ✔  Command: `pwsh -c get-installedmodule -name az` stdout should match /\s+Az\s+PSGallery\s+/


Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped

```

## Publishing the Docker Image

While creating the image automatically requires Ansible and, in turn, Linux, using the image does not. Publishing the Docker image artifact to a location like Docker Hub
lets anyone use it relatively easily.

For example, to commit a recent rebuild (v2) to my (sbonds) docker hub repository:

```bash
$ docker commit azure-arm sbonds/centos_az_pwsh_git:v2
sha256:d3852de8e3863db3195b71355bfbcd6506e2b372533ac2b0d5179c3cdfb34ad0
$ docker push sbonds/centos_az_pwsh_git:v2
The push refers to a repository [docker.io/sbonds/centos_az_pwsh_git]
05054a7d1c7a: Pushed
d69483a6face: Layer already exists
v2: digest: sha256:194be9f07501c1f5f0e978d4d973e7f1b39ab41e27e8ad98b30e0725c74fbcbd size: 742
```

## Using the Docker Image

```bash
docker pull sbonds/centos_az_pwsh_git
docker run -it sbonds/centos_az_pwsh_git pwsh
```
