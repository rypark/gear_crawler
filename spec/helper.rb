ENV['RACK_ENV'] = 'test'
ENV['USE_VCR_CACHING'] = 'false'

require 'minitest/autorun'
require_relative '../gear_crawler'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end
