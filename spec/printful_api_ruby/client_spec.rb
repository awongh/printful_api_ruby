# frozen_string_literal: true

require 'spec_helper'

describe Printful::Client do
  it 'should instantiate with consumer key and consumer secret' do
    expect do
      Printful::Client.new({
                             consumer_token: ENV.fetch('PRINTFUL_CONSUMER_TOKEN', nil),
                             consumer_secret: ENV.fetch('PRINTFUL_CONSUMER_SECRET', nil),
                             oauth_token: ENV.fetch('PRINTFUL_OAUTH_TOKEN', nil),
                             oauth_secret: ENV.fetch('PRINTFUL_OAUTH_SECRET', nil)
                           })
    end.not_to raise_error
  end

  describe 'api_endpoint' do
    after(:each) do
      Printful.reset
    end

    it 'should default to https://api.printful.com/' do
      client = Printful::Client.new
      expect(client.api_endpoint).to eq('https://api.printful.com/')
    end

    it 'should be set ' do
      Printful.api_endpoint = 'http://foo.dev'
      client = Printful::Client.new
      expect(client.api_endpoint).to eq('http://foo.dev/')
    end
  end

  describe 'web_endpoint' do
    after(:each) do
      Printful.reset
    end

    it 'should default to https://www.printful.com/' do
      client = Printful::Client.new
      expect(client.web_endpoint).to eq('https://www.printful.com/')
    end

    it 'should be set ' do
      Printful.web_endpoint = 'http://foo.dev/'
      client = Printful::Client.new
      expect(client.web_endpoint).to eq('http://foo.dev/')
    end
  end
end
