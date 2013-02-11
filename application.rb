# encoding: UTF-8

require 'haml'
require 'sinatra'
require 'sinatra/json'
require 'bluebook/abbreviation'
require 'bluebook/date_patch'

class BlackacreReports < Sinatra::Base
  helpers Sinatra::JSON

  set :haml, { :format => :html5 }

  configure :production do
    if ENV['GOOGLE_ANALYTICS_ID']
      require 'rack-google-analytics'
      use Rack::GoogleAnalytics,
        :tracker => ENV['GOOGLE_ANALYTICS_ID']
    end

    if ENV['CANONICAL_HOST']
      require 'rack-canonical-host'
      use Rack::CanonicalHost, ENV['CANONICAL_HOST']
    end
  end

  get '/' do
    haml :index
  end

  get '/abbreviate' do
    case params[:abbreviations].downcase.strip
    when '6'
      json :text => Bluebook::Abbreviation.table_6(params[:text])
    when '10'
      json :text => Bluebook::Abbreviation.table_10(params[:text])
    when '610'
      ten = Bluebook::Abbreviation.table_10(params[:text])
      json :text => Bluebook::Abbreviation.table_6(ten)
    else
      [400, {'error' =>
        "Unrecognized abbreviations: #{params[:abbreviations]}"
      }.to_json]
    end
  end

  get '/date' do
    begin
      json :text => Date.iso8601(params[:text]).to_bluebook
    rescue
      [400, {'error' => "Malformed request" + e.to_s }.to_json]
    end
  end
end
