class App
  module Views
    class Search < Mustache
    
      require 'date'
      
      DATE_FORMAT = '%Y-%m-%d'
      
      def today
        return DateTime.now.strftime( DATE_FORMAT )
      end
      
      def last_year
        year_ago = DateTime.now << 3
        return year_ago.strftime( DATE_FORMAT )
      end
      
    end
  end
end