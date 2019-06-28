# encoding: utf-8
# copyright: 2019, Steve Bonds

title 'Check that Azure CLI dependencies are installed'


control 'git-installed' do
  title 'Check that Git is installed'
  describe package ('git') do
    it { should be_installed }
  end
end

control 'powershell-installed' do
  title 'Check that PowerShell Core is installed'
  describe package ('powershell') do
    it { should be_installed }
  end
end

control 'AZ-module-installed' do
  title 'Check that the PowerShell AZ module is installed'
  describe command('pwsh -c get-installedmodule -name az') do
    # pwsh exits with status 0 even on error so that is not useful
    its('stdout') { should match /\s+Az\s+PSGallery\s+/ }
  end
end
