require 'spec_helper'

describe 'graylog2server' do
  let (:params) { { :path => '/opt/graylog' } }

  it "creates the graylog directory" do
    should contain_file('/opt/graylog').with(
      'ensure' => 'directory')
  end
end