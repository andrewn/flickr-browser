class FlickrBrowser
  
  require 'flickr'
  
  @flickr = nil
  @limit  = 
  
  def initialize( api_key='' )
    @flickr = Flickr.new( api_key )
  end
  
  def find( params={} )
    
    if params[:group_url] and !params[:group_url].empty?
      group_id = @flickr.find_by_url( params[:group_url] ).id
      params[:group_id] = group_id
    end
        
    params[:limit] = 5 unless params[:limit] 
    
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