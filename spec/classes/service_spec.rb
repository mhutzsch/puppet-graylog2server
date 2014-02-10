require 'spec_helper'

describe "graylog2server::service" do 

let(:pre_condition) { 'include graylog2server' }
let(:facts) {{:osfamily => "Debian"}}

  it "installs the graylog2server service on a machine" do
    should contain_service("graylog2server").with(
      'ensure' => 'running'
      )
  end

  it "creates the runfile for the runit service" do
    should contain_file("/etc/sv/graylog2server/run").with_content(
      %Q{#!/bin/bash\nCMD=\"java -jar /opt/graylog2-server/graylog2-server.jar\"\nOPTIONS=\"-f /opt/graylog2-server/etc/graylog2.conf\"\n\nexec chpst -u graylog2:graylog2 $CMD $OPTIONS 2>&1\n})
  end

  it "creates the log description for the runit service" do
    should contain_file("/etc/sv/graylog2server/log/run").with_content(
      %Q(#!/bin/bash\n\nexec chpst -u graylog2:graylog2 svlogd /var/log/graylog2server\n))
  end

end