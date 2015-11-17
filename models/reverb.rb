require 'nokogiri'
require 'open-uri'

class Reverb < Crawler

  BASE_URL = 'https://www.reverb.com/marketplace'

  # example search url: https://reverb.com/marketplace?query=ludwig+supraphonic
  def self.search(query, min: nil, max: nil)
    url = BASE_URL + "?query=#{query}"
    url << "&price_min=#{min}&price_max=#{max}" if min || max
    doc = Nokogiri::HTML(open(url))

    results = []
    doc.css('li.product').each do |result|
      thumbnail = result.at_css('.product-image > a > img').attribute('src').value
      details   = result.at_css('.product-body')
      title     = details.at_css('.heading-4').text
      href      = 'https://www.reverb.com' + details.at_css('.heading-4 > a').attribute('href').value
      price     = details.at_css('.text-orange').text.strip

      results << Result.new(thumbnail, title, href, price, 'Reverb.com')
    end

    new(results, min: min, max: max)
  end

end
