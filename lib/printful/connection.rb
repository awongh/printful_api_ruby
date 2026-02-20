# frozen_string_literal: true

require 'printful/middleware/raise_printful_api_error'

module Printful
  module Connection
    private

    def connection(raw = false, force_urlencoded = false)
      url = Printful.api_endpoint

      options = {
        url: url,
        ssl: { verify: false },
      }

      Faraday.new(options) do |builder|
        builder.request :json
        builder.request :authorization, 'Bearer', @oauth_token

        builder.response :raise_printful_api_error
        builder.response :json, parser_options: { symbolize_names: true }
        builder.response :logger

        self.connection_options.each { |op, v| builder.options[op] = v }

        builder.adapter(*Array(adapter))
      end
    end
  end
end
