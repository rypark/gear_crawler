require 'nokogiri'
require 'open-uri'

class GuitarCenter < Crawler

  BASE_URL = 'http://www.guitarcenter.com/Used/'

  # example search url: http://www.guitarcenter.com/Used/?Ntt=ludwig%20supraphonic&Ns=r
  def self.search(query, min: nil, max: nil)
    url = BASE_URL + "?Ntt=#{query}&Ns=r"
    doc = Nokogiri::HTML(open(url))

    results = []
    doc.css('li.compare').each do |result|
      thumbnail = result.at_css('.thumb > span > img').attr('data-original')
      details   = result.at_css('.productTitle > strong > a')
      title     = details.text.strip
      href      = "http://www.guitarcenter.com" + details.attribute('href').value
      price     = result.at_css('.productPrice').text.strip.gsub('.00', '').insert(-3, '.')

      results << Result.new(thumbnail, title, href, price, 'Guitar Center')
    end

    new(results, min: min, max: max)
  end

end
