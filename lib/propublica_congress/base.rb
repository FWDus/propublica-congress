module PropublicaCongress
  class Base
    API_VERSION = 'v1'
    API_URI = 'api.propublica.org'
    API_BASE = "https://#{API_URI}/congress/#{API_VERSION}"
    CURRENT_CONGRESS = 115

    @@api_key = nil
    @@copyright = nil

    class << self

      def check_offset(offset)
        raise "Offset must be a multiple of 20" if offset % 20 != 0
      end

      ##
      # Builds a request URI to call the API server
      def build_request_url(path, params)
        URI::HTTP.build host: API_SERVER,
        path: "#{API_BASE}/#{path}.json",
        query: params.map {|k,v| "#{k}=#{v}"}.join('&')
      end

      def invoke(path, params={})
        begin
          if @@api_key.nil?
            raise "You must initialize the API key before you run any API queries"
          end

          full_params = params.merge({"api-key" => @@api_key})
          full_params.delete_if {|k,v| v.nil?}

          check_offset(params[:offset]) if params[:offset]

          uri = build_request_url(path, full_params)

          reply = uri.read
          parsed_reply = JSON.parse reply

          if parsed_reply.nil?
            raise "Empty reply returned from API"
          end

          @@copyright = parsed_reply['copyright']
          @@cycle = parsed_reply['cycle']
          @@base_uri = parsed_reply['base_uri']

          parsed_reply
        rescue OpenURI::HTTPError => e
          if e.message =~ /^404/
            return nil
          end

          raise "Error connecting to URL #{uri} #{e}"
        end
      end
    end
  end
end