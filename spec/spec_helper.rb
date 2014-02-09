require 'rspec-puppet'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.expand_path(File.join(__FILE__, '..', '..', '..'))
  c.manifest_dir = File.join(fixture_path, 'manifests')
end
