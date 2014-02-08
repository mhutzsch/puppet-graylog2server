require 'spec_helper'

describe 'graylog2server' do
  let (:params) { 
    { :path => '/opt/graylog', 
      :user => 'graylog2'} }

  it "creates the graylog directory" do
    should contain_file('/opt/graylog').with(
      'ensure' => 'directory')
  end

  it "creates the graylog2 user" do
    should contain_user('graylog2').with(
      'ensure' => 'present',
      'home'   => '/opt/graylog')
  end
end