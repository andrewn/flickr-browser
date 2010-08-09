require 'rubygems'
require 'flickr'

FLICKR_API_KEY  = '23fa57dfb07ea2e682067df90fdf08a9'
f = Flickr.new( FLICKR_API_KEY )

g = f.find_by_url('http://www.flickr.com/groups/weatherphoto/')

puts g.id

p = g.getPhotos()
puts p.length