require 'spec_helper'
require 'serverspec'

describe file('/usr/local/etc/pkg/repos/FreeBSD.conf') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match /^FreeBSD: {\n\s+enabled: false,\n}/ }
end

["10.3.build", "10.1.build"].each do |r|
  describe file("/usr/local/etc/pkg/repos/#{r}.conf") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
    its(:content) { should match /^#{ Regexp.escape(r) }: {/ }
    its(:content) { should match %r{url: "pkg\+http://#{ Regexp.escape(r) }\.reallyenglish.com\/\$\{ABI\}",} }
    its(:content) { should match /mirror_type: "srv",/ }
    its(:content) { should match /signature_type: "none",/ }
    its(:content) { should match /enabled:\s+true/ }
    its(:content) { should match /priority:\s+100/ }
  end
end

describe command('pkg -vv') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match(/^$/) }
  its(:stdout) { should match(/^\s+10\.3\.build:\s+{/) }
  its(:stdout) { should match(/^\s+10\.1\.build:\s+{/) }
  its(:stdout) { should_not match(/^\s+FreeBSD:\s+{/) }
end
