require 'minitest/autorun'
require_relative '../models/crawler'
Dir[__dir__ + '/../models/**/*.rb'].each { |file| require file }
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end
