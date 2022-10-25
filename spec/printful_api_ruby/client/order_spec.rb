require 'spec_helper'

describe Printful::Client do
  let(:client) do
    printful_client
  end
  
  after(:each) do
    printful_client.reset
  end

  it "api error" do
    VCR.use_cassette('create_order') do
      response = client.post('/orders',{
        foo: 'bar'
      })
      #response.should be_an_instance_of(Hashie::Mash)
       expect( response[:result] ).to eq('The access token provided is invalid.')
    end
  end 
end
