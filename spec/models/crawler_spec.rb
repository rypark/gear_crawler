require_relative '../helper'

module GearCrawler

  class BogusCrawler < Crawler; end

  describe Crawler do

    before do
      @results = [
        Crawler::Result.new('thumbnail.jpg', 'Gitfiddle', 'gitfiddle.com', '234.56', 'Reverb.com'),
        Crawler::Result.new('thumbnail.jpg', 'Fiddlegit', 'fiddlegit.com', '123.45', 'Reverb.com'),
      ]
    end

    describe '.crawl' do

      it 'raises error if subclass does not implement .search' do
        err = ->{ BogusCrawler.crawl('Fender P Bass') }.must_raise RuntimeError
        err.message.must_equal 'Subclass should implement .search'
      end

    end

    it 'returns sorted results' do
      crawler = Crawler.new(@results)
      crawler.results.map(&:price).must_equal [123.45, 234.56]
    end

    it 'considers min when present' do
      crawler = Crawler.new(@results, min: 200)
      crawler.results.map(&:price).must_equal [234.56]
    end

    it 'considers max when present' do
      crawler = Crawler.new(@results, max: 200)
      crawler.results.map(&:price).must_equal [123.45]
    end

  end
end
