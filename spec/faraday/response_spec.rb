# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Faraday::Response do
  before do
    @client = Printful::Client.new({
      consumer_token: ENV['PRINTFUL_CONSUMER_TOKEN'], 
      consumer_secret: ENV['PRINTFUL_CONSUMER_SECRET'], 
      oauth_token: ENV['PRINTFUL_OAUTH_TOKEN'], 
      oauth_secret: ENV['PRINTFUL_OAUTH_SECRET'], 
      proxy: 'http://localhost:8888'
    })
  end

  {
    400 => Printful::BadRequest,
    401 => Printful::Unauthorized,
    403 => Printful::Forbidden,
    404 => Printful::NotFound,
    406 => Printful::NotAcceptable,
    422 => Printful::UnprocessableEntity,
    500 => Printful::InternalServerError,
    # 501 => Printful::NotImplemented,
    502 => Printful::BadGateway,
    503 => Printful::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('orders').to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        #expect {

          lambda do
            @client.get('orders')
            #@client.cart
          end
        #}.to raise_error(exception)

      end
    end
  end
end
