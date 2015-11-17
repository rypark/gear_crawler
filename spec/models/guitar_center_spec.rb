require_relative '../helper'

describe GuitarCenter do

  it 'returns valid results' do
    VCR.use_cassette('GuitarCenter_ludwig_supraphonic') do
      results = GuitarCenter.search('ludwig supraphonic').results
      results.wont_be_empty

      result = results.first
      result.thumbnail.must_equal "http://media.guitarcenter.com/is/image/MMGS7/1970s-5X14-Supraphonic-Snare-Drum/000000111597947-00-180x180.jpg"
      result.title.must_equal     "Vintage Ludwig 1970s 5X14 Supraphonic Snare Drum"
      result.href.must_equal      "http://www.guitarcenter.com/Used/Ludwig/Vintage-1970s-5X14-Supraphonic-Snare-Drum-111597947.gc"
      result.price.must_equal     179.99
      result.source.must_equal    "Guitar Center"
    end
  end

end
