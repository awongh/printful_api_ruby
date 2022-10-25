require 'faraday/response/raise_reshape_api_error'

module Printful
  module Connection
    private
    def oauth_data
      {
        oauth_token: @oauth_token,
        token_type: :bearer
      }
    end

    def connection(raw=false, force_urlencoded=false)
      url = "#{Printful.api_endpoint}"

      options = {
        url: url,
        # proxy: proxy,
        ssl: { verify: false },
      }


      connection = Faraday.new(options) do |builder|
        builder.adapter Faraday::Response::RaisePrintfulApiError

        builder.request :json
        #builder.request :oauth2, oauth_data

        builder.request :authorization, 'Bearer', @oauth_token

        builder.response :logger
        builder.response :json, parser_options: { symbolize_names: true }


        #set the connection options passed in the constructor
        # https://github.com/lostisland/faraday/issues/417
        # http://stackoverflow.com/questions/8098584/faraday-timeout
        self.connection_options.each{ |op,v| builder.options[op] = v }

        builder.adapter *adapter
      end
      connection
    end
  end
end
