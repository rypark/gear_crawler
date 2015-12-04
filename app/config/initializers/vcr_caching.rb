require 'vcr'

# will save all searches; reruns them if they're 24+ hrs old.
ENV['USE_VCR_CACHING'] ||= 'true'

if ENV['USE_VCR_CACHING'] == 'true'
  VCR.configure do |config|
    config.cassette_library_dir = "vcr_cassettes"
    config.hook_into :webmock
    config.default_cassette_options = {
      match_requests_on: [
        :method,
        VCR.request_matchers.uri_without_param(:price_min, :price_max)
        # TODO ignoring min/max causes some results to be lost
        #      if the site accepts the args (currently just Reverb)
      ]
    }
  end
end
