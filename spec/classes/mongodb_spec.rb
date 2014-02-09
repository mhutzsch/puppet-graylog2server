require 'spec_helper'

describe 'graylog2server::mongodb' do
  let(:facts) { { :osfamily  => 'Debian' } }

  it "installs the mongodb package" do
    should contain_package("mongodb-10gen").
      with('ensure' => 'installed')
  end

  it "runs the mognodb" do
    should contain_service("mongodb").
      with('ensure' => 'running')
  end

end