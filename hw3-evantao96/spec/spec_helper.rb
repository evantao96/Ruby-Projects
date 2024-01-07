require 'simplecov'
SimpleCov.start

require_relative '../song'
require_relative '../radio'
require 'timeout'

RSpec.configure do |config|
  config.before(:all) { $stdout = StringIO.new }
  config.after(:all) { $stdout = STDOUT }
end
