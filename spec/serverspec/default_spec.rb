require 'spec_helper'
require 'serverspec'

describe file('/usr/local/etc/pkg/repos/FreeBSD.conf') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match /FreeBSD: { enabled: no }/ }
end

describe file('/usr/local/etc/pkg/repos/reallyenglish.conf') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match /^reallyenglish: {/ }
  its(:content) { should match /url: "pkg\+http:\/\/10\.3\.build\.reallyenglish.com\/\$\{ABI\}",/ }
  its(:content) { should match /mirror_type: "srv",/ }
  its(:content) { should match /signature_type: "none",/ }
  its(:content) { should match /enabled:\s+yes/ }
end

describe command('pkg -vv') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match /^$/ }
end
