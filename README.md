# azure-learning

Mini-projects from the process of learning the Microsoft Azure cloud

## Automated Azure ARM Powershell Controller Host Setup

Chris Neale posted [this great guide to setting up a Docker host for running Azure scripts](https://www.chrisneale.org/PowerShellAzModulesAndGitInDocker/). 
Often the hardest part for getting automation working is creating an environment where the automation works. His config works great, but perhaps it's worth
even automating that setup? Of course, this itself invites the classic chicken-and-egg problem-- if we automate that setup, how is the automation needed
for it set up?

I'm going to just dodge that question and instead assume that the following are set up and working. It's already true for me, which is why this exercise
even started.

* Docker
* Ansible

Due to that second one, this process will only work on Linux.

### Test-Driven Infrastructure

An Inspec test is present to confirm the image is set up correctly.

```output
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
