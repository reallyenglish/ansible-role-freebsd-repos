require 'spec_helper'

class ServiceNotReady < StandardError
end

sleep 10 if ENV['JENKINS_HOME']

context 'after provisioning finished' do

  describe server(:server1) do

    it "is able to install logstash5" do
      result = current_server.ssh_exec("sudo env HTTP_PROXY=#{ http_proxy_url if proxy_running? } pkg install logstash5")
      expect(result).to match(/OK/)
    end

  end

end
