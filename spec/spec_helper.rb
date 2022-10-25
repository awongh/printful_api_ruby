require 'dotenv/load'
unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec"
  end
end

require 'printful'
require 'rspec'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
end

def a_get(url)
  a_request(:get, printful_url(url))
end

def a_post(url)
  a_request(:post, printful_url(url))
end

def a_put(url)
  a_request(:put, printful_url(url))
end

def a_delete(url)
  a_request(:delete, printful_url(url))
end

def stub_get(url)
  stub_request(:get, printful_url(url))
end

def stub_post(url)
  stub_request(:post, printful_url(url))
end

def stub_put(url)
  stub_request(:put, printful_url(url))
end

def stub_delete(url)
  stub_request(:delete, printful_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def printful_url(url)
  "https://api.printful.com/"
end

def printful_client
  Printful::Client.new({
    consumer_token: ENV['PRINTFUL_CONSUMER_TOKEN'], 
    consumer_secret: ENV['PRINTFUL_CONSUMER_SECRET'], 
    oauth_token: ENV['PRINTFUL_OAUTH_TOKEN'], 
    oauth_secret: ENV['PRINTFUL_OAUTH_SECRET']
  })
end
