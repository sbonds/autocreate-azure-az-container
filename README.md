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

