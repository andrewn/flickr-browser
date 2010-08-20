class FlickrBrowser
  
  require 'vendor/flickr-1.0.2/flickr'
  
  class Flickr::Photo
    def to_h
      {
        :title  => title,
        :url    => url,
        :sizes  => sizes_to_hash(sizes)
      }
    end
    
    def sizes_to_hash( sizes ) 
      h = {}
      sizes.each do | s |
        label = s['label']
        h[label] = s
      end
      return h
    end
  end
  
  @flickr = nil
  
  def initialize( api_key='' )
    @flickr = Flickr.new( api_key )
  end
  
  def find( params={} )
    if params[:group_url] and !params[:group_url].empty?
      group_id = @flickr.find_by_url( params[:group_url] ).id
      params[:group_id] = group_id
    end
    
    if params[:limit]
      params.delete :limit
    end
    
    if params[:search_term]
      params[:text] = params[:search_term]
      params.delete :search_term
    end
    
    compact_hash!( params )
    stringify_hash!( params )
    
    puts "*************\n\nRequesting:"
    p params
    puts "\n\n*************"
    
    @flickr.photos( params )
  end
    
  private
  def compact_hash!( hash )
    hash.each do | k,v |
      if (v.respond_to? :nil? and v.nil?) or (v.respond_to? :empty? and v.empty?)
        hash.delete(k) 
      end
    end
  end
  
  def stringify_hash!( hash )
    hash.each do | k,v |
      hash[k] = hash[k].to_s
    end
  end
end