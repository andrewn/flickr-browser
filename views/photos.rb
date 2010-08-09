class App
  module Views
    class Photos < Mustache
      def photos
        to_display = []
        photos = @photos
        photos.each do | photo |
          to_display << { :url => photo.source('Square') }
        end
        to_display
      end
    end
  end
end