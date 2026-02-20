# frozen_string_literal: true

require 'spec_helper'

describe Printful::Client do
  let(:client) do
    printful_client
  end

  after(:each) do
    printful_client.reset
  end

  it "gets all orders" do
    VCR.use_cassette('get_orders') do
      response = client.get('/orders')
      expect(response[:result]).to be_an_instance_of(Array)
    end
  end

  it "creates an order with sync variant id" do
    VCR.use_cassette('create_sync_vairant_id_order') do
      response = client.post('/orders', {
        external_id: 666,
        shipping: 'STANDARD',
        recipient: {
          name: 'nack wack',
          address1: '10735 Montego Dr',
          address2: '#321',
          city: 'San Diego',
          state_code: 'CA',
          country_code: 'US',
          zip: '92124',
          phone: '',
          email: 'nack@a15i.net',
        },
        items: [
          {
            'sync_variant_id': 3554393160,
            'quantity': 1,
            'files': [
              {
                "url": "http://example.com/files/posters/poster_1.jpg"
              }
            ]
          }
        ],
        retail_costs: {
          currency: 'USD',
          subtotal: '123',
          discount: '12',
          shipping: '12',
          tax: '1.23'
        },
      })
      pp response
      expect(response[:code]).to eq(200)
      expect(response[:result]).to be_an_instance_of(Hash)
    end
  end
end
