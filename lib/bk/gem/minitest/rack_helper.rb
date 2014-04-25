BK::Gem::Minitest::ColoredLogger.new.green 'Testing: Loading Rack helpers...'
require 'rack/test'
require 'rack/mock'
require 'rack/request'
require 'rack/response'

include Rack::Test::Methods
