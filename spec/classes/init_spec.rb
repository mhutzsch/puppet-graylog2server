require 'spec_helper'

describe 'graylog2server' do
  
  let (:params) { 
    { :graylog2serverpath => '/opt/graylog', 
      :mongodb            => 'false' }
  }

  let(:facts) { { :osfamily  => 'Debian' } }

  it "creates the graylog directory" do
    should contain_file('/opt/graylog').with(
      'ensure' => 'directory')
  end
end