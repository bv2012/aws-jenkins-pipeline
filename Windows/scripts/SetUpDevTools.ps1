Set-ExecutionPolicy unrestricted

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Globally Auto confirm every action
choco feature enable -n allowGlobalConfirmation

# Install Python 2.x 2.7.15
choco install python2

# Install .net 4.5.2
choco install netfx-4.5.2-devpack

# Install .net 4.8
choco install netfx-4.8-devpack



# Install build tools 2015
choco install microsoft-build-tools --version 14.0.25420.1

# Install JDK 8 for Bamboo
choco install jdk8

choco install nuget.commandline
choco install nunit-console-runner
# Extension for generating results readable by Bamboo
choco install nunit-extension-nunit-v2-result-writer
choco install git.install

# Install Pester to run server tests
choco install Pester

# install VS2019

choco install -y visualstudio2019professional  

# install docker
choco install -y docker

