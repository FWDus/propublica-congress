require 'httparty'
require 'json'

module PropublicaCongress
  class Base
    
    API_URI = 'https://api.propublica.org'
    API_VERSION = 'v1'
    CURRENT_CONGRESS = 115

    @@api_key = ENV['PROPUBLICA_API_KEY']
    @@copyright = nil

    class << self
      ##
      # Set the API key used for operations. This needs to be called
      # before any requests against the API. To obtain an API key, go to
      # https://propublica.github.io/congress-api-docs/#congress-api-documentation
      def api_key=(key)
        @@api_key = key
      end

      def api_key
        @@api_key
      end

      def check_offset(offset)
        raise "Offset must be a multiple of 20" if offset % 20 != 0
      end
    end
  end
end