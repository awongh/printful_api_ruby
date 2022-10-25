require 'spec_helper'

describe Printful::Client do
  let(:client) do
    printful_client
  end
  
  after(:each) do
    printful_client.reset
  end

  it "get all orders" do
    #VCR.use_cassette('get_orders') do
      response = client.get('/orders')
      expect( response[:result] ).to be_an_instance_of(Array)
    #end
  end 
end
