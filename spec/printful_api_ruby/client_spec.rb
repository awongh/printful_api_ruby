require 'spec_helper'

describe Printful::Client do
  it 'should instantiate with consumer key and consumer secret' do
    proc {
      Printful::Client.new({
        consumer_token: ENV['PRINTFUL_CONSUMER_TOKEN'], 
        consumer_secret: ENV['PRINTFUL_CONSUMER_SECRET'], 
        oauth_token: ENV['PRINTFUL_OAUTH_TOKEN'], 
        oauth_secret: ENV['PRINTFUL_OAUTH_SECRET']
      })
    }.should_not raise_exception
  end

  describe "api_endpoint" do
    after(:each) do
      Printful.reset
    end

    it "should default to https://api.printful.com/" do
      client = Printful::Client.new
      client.api_endpoint.should == 'https://api.printful.com/'
    end

    it "should be set " do
      Printful.api_endpoint = 'http://foo.dev'
      client = Printful::Client.new
      client.api_endpoint.should == 'http://foo.dev/'
    end
  end
  
  describe "web_endpoint" do
    after(:each) do
      Printful.reset
    end

    it "should default to https://www.printful.com/" do
      client = Printful::Client.new
      client.web_endpoint.should == 'https://www.printful.com/'
    end

    it "should be set " do
      Printful.web_endpoint = 'http://foo.dev'
      client = Printful::Client.new
      client.web_endpoint.should == 'http://foo.dev/'
    end
  end

end
