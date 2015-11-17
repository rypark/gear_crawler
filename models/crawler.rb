# TODO Other crawlers:
# - craigslist (maybe use https://github.com/mark-nery/craigslist_scraper)
# - ebay
# - music go round?
# - maybe even amazon?

class Crawler

  # Subclasses should implement self.search and return a new instance

  attr_reader :results

  def initialize(results, min: nil, max: nil)
    @results = results.sort_by(&:price)
    @results.reject! { |r| r.price < Float(min) } unless blank?(min)
    @results.reject! { |r| r.price > Float(max) } unless blank?(max)
  end

private

  def blank?(str_or_num)
    str_or_num.respond_to?(:empty?) ? !!str_or_num.empty? : !str_or_num
  end

  class Result
    attr_reader :thumbnail, :title, :href, :price, :source

    def initialize(thumbnail, title, href, price, source)
      @thumbnail = thumbnail
      @title     = title
      @href      = href
      @price     = Float(price.gsub(/\$|\,/, ''))
      @source    = source
    end
  end
end
