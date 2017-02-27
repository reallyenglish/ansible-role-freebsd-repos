require 'infrataster/rspec'
require 'socket'
require 'shellwords'
require 'socket'

# @return [String] public IP address of workstation used for egress traffic
def local_ip
  @local_ip ||= begin
    # turn off reverse DNS resolution temporarily
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true

    # open UDP socket so that it never send anything over the network
    UDPSocket.open do |s|
      s.connect '8.8.8.8', 1 # any global IP address works here
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end
end
# @return [Integer] default listening port
def local_port ; ENV["ANSIBLE_LOCAL_PROXY"] ? ENV["ANSIBLE_LOCAL_PROXY"] : 8080 ; end
# @return [String] the proxy URL
def http_proxy_url ; "http://#{local_ip}:#{local_port}" ; end
# @return [TrueClass,FalseClass] whether or not the port is listening
def proxy_running?
  socket = TCPSocket.new(local_ip, local_port)
  true
rescue SocketError, Errno::ECONNREFUSED,
  Errno::EHOSTUNREACH, Errno::ENETUNREACH, IOError
  false
rescue Errno::EPERM, Errno::ETIMEDOUT
  false
ensure
  socket && socket.close
end
def http_proxy ; proxy_running? ? http_proxy_url : "" ; end

ENV['VAGRANT_CWD'] = File.dirname(__FILE__)
ENV['LANG'] = 'C'

if ENV['JENKINS_HOME']
  # XXX "bundle exec vagrant" fails to load.
  # https://github.com/bundler/bundler/issues/4602
  #
  # > bundle exec vagrant --version
  # bundler: failed to load command: vagrant (/usr/local/bin/vagrant)
  # Gem::Exception: can't find executable vagrant
  #   /usr/local/lib/ruby/gems/2.2/gems/bundler-1.12.1/lib/bundler/rubygems_integration.rb:373:in `block in replace_bin_path'
  #   /usr/local/lib/ruby/gems/2.2/gems/bundler-1.12.1/lib/bundler/rubygems_integration.rb:387:in `block in replace_bin_path'
  #   /usr/local/bin/vagrant:23:in `<top (required)>'
  #
  # this causes "vagrant ssh-config" to fail, invoked in a spec file, i.e. when
  # you need to ssh to a vagrant host.
  #
  # include the path of bin to vagrant
  vagrant_real_path = `pkg info -l vagrant | grep -v '/usr/local/bin/vagrant' | grep -E 'bin\/vagrant$'| sed -e 's/^[[:space:]]*//'`
  vagrant_bin_dir = File.dirname(vagrant_real_path)
  ENV['PATH'] = "#{vagrant_bin_dir}:#{ENV['PATH']}"
end

Infrataster::Server.define(
  :server1,
  '192.168.21.200',
  vagrant: true
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
