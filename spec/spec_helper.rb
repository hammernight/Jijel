require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../'))

RSpec.configure do |config|
  config.mock_with :rspec
end