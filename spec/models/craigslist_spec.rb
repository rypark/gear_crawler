require_relative '../helper'

describe Craigslist do

  it 'returns valid results' do
    VCR.use_cassette('Craigslist_fender_strat') do
      results = Craigslist.search('fender strat').results
      results.wont_be_empty

      result = results.first
      result.thumbnail.must_equal "http://placekitten.com/180/180"
      result.title.must_equal     "Want to buy Strat body"
      result.href.must_equal      "http://oklahomacity.craigslist.org/msg/5315312046.html"
      result.price.must_equal     1.0
      result.source.must_equal    "Craigslist"
    end
  end

  it 'handles results with no price' do
    skip
  end

end
