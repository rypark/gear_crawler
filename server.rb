require 'sinatra/base'
require_relative 'gear_crawler'

module GearCrawler
  class SinatraApp < Sinatra::Base

    set :views, Proc.new { File.join(__dir__, 'app/views') }

    CRAWLERS = [
      GuitarCenter,
      Reverb,
      Craigslist,
    ]

    get '/' do
      results           = []
      selected_crawlers = find_selected_crawlers

      if params[:q]
        selected_crawlers.each do |crawler|

          results.push(
            *crawler
            .crawl(params[:q], min: params[:min], max: params[:max])
            .results
          )

        end
        results.sort_by!(&:price)
      end

      haml :index, locals: {results: results, recent_searches: recent_searches, selected_crawlers: selected_crawlers.map(&:to_s)}
    end

  private
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
end
