Dir[__dir__ + '/app/config/initializers/*.rb'].each { |file| require file }
Dir[__dir__ + '/app/models/**/*.rb'].each { |file| require file }

module GearCrawler

  ONE_DAY         = 86400 # Since we have have no `1.days` from rails :)
  USE_VCR_CACHING = (ENV['USE_VCR_CACHING'] == 'true')

end
