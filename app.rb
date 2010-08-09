require 'rubygems'

require 'models/flickr'

require 'sinatra/base'
require 'mustache/sinatra'

require 'json'

class App < Sinatra::Base
  register Mustache::Sinatra
  require 'views/layout'
  
  set :mustache, {
    :views      => 'views/',
    :templates  => 'templates/'
  }
  
  # Set up flickr
  FLICKR_API_KEY  = '23fa57dfb07ea2e682067df90fdf08a9'
  flickr          = FlickrBrowser.new( FLICKR_API_KEY )
  
  # Routes
  get '/' do
    "Hello world"
  end
  
  get '/search' do 
    mustache :search
  end
  
  get %r{/photos.?(json)?} do
    
    format = ( params[:captures] ? params[:captures].first : 'html' ) 
        
    min_taken_date = params[:from]
    max_taken_date = params[:to]
    
    max_taken_date = nil if min_taken_date == max_taken_date
          
    finder_params = {
      :sort           => 'interestingness-desc',
      :min_taken_date => min_taken_date,
      :max_taken_date => max_taken_date,
      :group_url      => params[:group],
      :per_page       => params[:limit] # flickr's 'per_page' param
    }
    
    @photos = flickr.find( finder_params )
    
    case format
      when 'json' then
        content_type :json
         @photos.to_json
      else
        mustache :photos
    end
    
  end
  
end

