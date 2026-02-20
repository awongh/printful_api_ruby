# frozen_string_literal: true

require 'faraday'
require 'json'

module Printful
  class RaisePrintfulApiError < Faraday::Middleware
    def on_complete(env)
      case env.status
      when 400 then raise Printful::BadRequest, error_message(env)
      when 401 then raise Printful::Unauthorized, error_message(env)
      when 403 then raise Printful::Forbidden, error_message(env)
      when 404 then raise Printful::NotFound, error_message(env)
      when 406 then raise Printful::NotAcceptable, error_message(env)
      when 422 then raise Printful::UnprocessableEntity, error_message(env)
      when 500 then raise Printful::InternalServerError, error_message(env)
      when 502 then raise Printful::BadGateway, error_message(env)
      when 503 then raise Printful::ServiceUnavailable, error_message(env)
      end
    end

    private

    def error_message(env)
      message = if (body = env.body) && !body.empty?
                  body = JSON.parse(body, symbolize_names: true) if body.is_a?(String)
                  ": #{body[:error] || body[:message] || ''}"
                else
                  ''
                end
      "#{env.method.to_s.upcase} #{env.url}: #{env.status}#{message}"
    end
  end
end

Faraday::Response.register_middleware(raise_printful_api_error: Printful::RaisePrintfulApiError)
