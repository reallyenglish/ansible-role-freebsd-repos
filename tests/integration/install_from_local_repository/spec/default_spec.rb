require 'spec_helper'

class ServiceNotReady < StandardError
end

sleep 10 if ENV['JENKINS_HOME']

context 'after provisioning finished' do

  describe server(:server1) do

    it "is able to install logstash5" do
      result = current_server.ssh_exec("sudo env ASSUME_ALWAYS_YES=yes HTTP_PROXY=#{ http_proxy } pkg install logstash5 && echo LOGSTASH_INSTALLED")
      expect(result).to match(/^(?:\[\d+\/\d+\] Installing logstash|The most recent version of packages are already installed)/)
      expect(result).to match(/LOGSTASH_INSTALLED/)
    end

  end

end
