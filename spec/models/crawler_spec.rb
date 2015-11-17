require_relative '../helper'

describe Crawler do

  before do
    @results = [
      Crawler::Result.new('thumbnail.jpg', 'Gitfiddle', 'gitfiddle.com', '234.56', 'Reverb.com'),
      Crawler::Result.new('thumbnail.jpg', 'Fiddlegit', 'fiddlegit.com', '123.45', 'Reverb.com'),
    ]
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
