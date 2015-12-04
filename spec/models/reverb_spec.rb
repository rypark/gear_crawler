require_relative '../helper'

module GearCrawler
  describe Reverb do

    it 'returns valid results' do
      VCR.use_cassette('Reverb_grosh_electrajet') do
        results = Reverb.search('grosh electrajet').results
        results.wont_be_empty

        result = results.first
        result.thumbnail.must_equal "https://reverb-res.cloudinary.com/image/upload/a_exif,c_fill,f_auto,fl_progressive,q_75,w_226/v1447466066/yxvsg5qyuv2bmwigtmws.jpg"
        result.title.must_equal     "Don Grosh Electrajet Shoreline Gold"
        result.href.must_equal      "https://www.reverb.com/item/1341592-don-grosh-electrajet-shoreline-gold"
        result.price.must_equal     1349.0
        result.source.must_equal    "Reverb.com"
      end
    end

  end
end
