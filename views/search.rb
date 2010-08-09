class App
  module Views
    class Search < Mustache
      
      DATE_FORMAT = '%Y-%m-%d'
      
      def today
        return Time.now.strftime( DATE_FORMAT )
      end

    end
  end
end