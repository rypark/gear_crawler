# TODO Other crawlers:
# - ebay
# - music go round?
# - maybe even amazon?

module GearCrawler
  class Crawler

    # Subclasses should implement self.search and return a new instance

    attr_reader :results

    class << self

      def crawl(query, min: nil, max: nil)
        with_vcr_caching(query) do
          results = search(query, min: min, max: max).results
          new(results, min: min, max: max)
        end
      end

      def with_vcr_caching(query, &block)
        if GearCrawler::USE_VCR_CACHING
          VCR.use_cassette("#{self}_#{query}", re_record_interval: ONE_DAY) do
            yield
          end
        else
          yield
        end
      end

      def search(query, min: nil, max: nil)
        raise "Subclass should implement .search"
      end

    end

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
end
