require 'nokogiri'
require 'open-uri'

class Craigslist < Crawler

  BASE_URL = 'http://oklahomacity.craigslist.org/search/sss'

  # example search url: http://oklahomacity.craigslist.org/search/sss?excats=42-153-1&sort=rel&query=ludwig+supraphonic
  def self.search(query, min: nil, max: nil)
    url = BASE_URL + "?sort=rel&query=#{query.gsub(' ', '+')}"
    doc = Nokogiri::HTML(open(url))

    results = []
    doc.css('.content > p.row').each do |result|
      if thumbnail_id_list = result.at_css('a.i').attr('data-ids')
        thumbnail_id = thumbnail_id_list.split(',')[0].gsub(/^0:/, '')
        thumbnail    = "http://images.craigslist.org/#{thumbnail_id}_300x300.jpg"
      else
        thumbnail = 'http://placekitten.com/180/180' # teehee
      end

      details_link = result.at_css('a.hdrlnk')
      title        = details_link.text.strip
      href         = "http://oklahomacity.craigslist.org" + details_link.attr('href')
      price_node   = result.at_css('span.price')
      price        = price_node ? price_node.text.strip : nil

      # TODO just rejecting empty price results for now.
      #      need more sophisticated price handling
      if price
        results << Result.new(thumbnail, title, href, price, 'Craigslist')
      end
    end

    new(results, min: min, max: max)
  end

end
