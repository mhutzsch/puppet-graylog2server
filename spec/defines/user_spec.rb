require 'spec_helper'

describe 'graylog2server::user' do
  
  let (:title) {'graylog2'}
  let (:params) { {'user' => 'graylog2', 'home' => '/opt/graylog2-server', 'uid' => 1042} }
  
  it "creates the graylog2 user" do
    should contain_user('graylog2').with(
      'ensure' => 'present',
      'home'   => '/opt/graylog2-server')
  end

end