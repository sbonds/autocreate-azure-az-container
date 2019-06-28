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
