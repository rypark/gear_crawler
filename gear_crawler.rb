require 'sinatra/base'
require_relative 'models/crawler'
Dir[__dir__ + '/models/**/*.rb'].each { |file| require file }
Dir[__dir__ + '/config/*.rb'].each    { |file| require file }

class GearCrawler < Sinatra::Base

  CRAWLERS = [
    GuitarCenter,
    Reverb,
    Craigslist,
  ]

  ONE_DAY = 86400 # Since we have have no `1.days` from rails :)

  get '/' do
    results           = []
    selected_crawlers = find_selected_crawlers

    if params[:q]
      selected_crawlers.each do |crawler|

        # TODO maybe move the VCR config into Crawler.search
        VCR.use_cassette("#{crawler}_#{params[:q]}", re_record_interval: ONE_DAY) do
          results.push(
            *crawler
            .search(params[:q], min: params[:min], max: params[:max])
            .results
          )
        end

      end
      results.sort_by!(&:price)
    end

    haml :index, locals: {results: results, recent_searches: recent_searches, selected_crawlers: selected_crawlers.map(&:to_s)}
  end

  def find_selected_crawlers
    if params[:crawlers] && params[:crawlers].any?
      CRAWLERS.select { |c| params[:crawlers].include?(c.to_s) }
    else
      CRAWLERS
    end
  end

  def recent_searches
    Dir[__dir__ + '/vcr_cassettes/*.yml'].map do |cassette|
      if Time.now - File.birthtime(cassette) <= ONE_DAY
        File.basename(cassette, '.yml').split('_')[1..-1].join(' ')
      end
    end.compact.uniq - [params[:q]]
  end


  run! if app_file == $0

end
