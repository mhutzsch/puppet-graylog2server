require 'spec_helper'

describe 'graylog2server::user' do

let(:pre_condition) { 'include graylog2server' }
let(:facts) {{:osfamily => "Debian"}}  

  it "creates the graylog2 user" do
    should contain_user('graylog2').with(
      'ensure' => 'present',
      'home'   => '/opt/graylog2-server')
  end

end