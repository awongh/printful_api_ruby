require 'faraday'

module Faraday
  class Response::RaisePrintfulApiError < Response
    def on_complete(response)
      case response[:status].to_i
      when 400
        raise Printful::BadRequest, error_message(response)
      when 401
        raise Printful::Unauthorized, error_message(response)
      when 403
        raise Printful::Forbidden, error_message(response)
      when 404
        raise Printful::NotFound, error_message(response)
      when 406
        raise Printful::NotAcceptable, error_message(response)
      when 422
        raise Printful::UnprocessableEntity, error_message(response)
      when 500
        raise Printful::InternalServerError, error_message(response)
      when 502
        raise Printful::BadGateway, error_message(response)
      when 503
        raise Printful::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      message = if (body = response[:body]) && !body.empty?
        if body.is_a?(String)
          body = JSON.parse(body, {symbolize_names: true})
        end
        ": #{body[:error] || body[:message] || ''}"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end
end
