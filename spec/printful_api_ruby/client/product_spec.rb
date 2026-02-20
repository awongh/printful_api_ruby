# frozen_string_literal: true

require 'spec_helper'

describe Printful::Client do
  let(:client) do
    printful_client
  end

  after(:each) do
    printful_client.reset
  end

  it 'gets all sync products' do
    VCR.use_cassette('get_sync_products') do
      response = client.get('/sync/products')
      expect(response[:result]).to be_an_instance_of(Array)
    end
  end

  it 'gets all catalog products' do
    VCR.use_cassette('get_catalog_products') do
      response = client.get('/products')
      expect(response[:result]).to be_an_instance_of(Array)
    end
  end

  it 'gets all store products' do
    VCR.use_cassette('get_store_products') do
      response = client.get('/store/products')
      expect(response[:result]).to be_an_instance_of(Array)
    end
  end

  it 'gets sync variants' do
    VCR.use_cassette('get_sync_variant_products') do
      response = client.get('/sync/products')

      expect(response[:result]).to be_an_instance_of(Array)
      expect(response[:code]).to eq(200)

      sync_variants = []
      sync_variant_ids = []

      response[:result].each_with_index do |product, _index|
        id = product[:id]
        products_response = client.get("/store/products/#{id}")
        expect(products_response[:code]).to eq(200)
        expect(products_response[:result]).to be_an_instance_of(Hash)

        products_response[:result][:sync_variants].each_with_index do |store_product, _sp_idx|
          sync_variants.push(store_product)
          sync_variant_ids.push(store_product[:id])
        end
      end

      {
        variants: sync_variants,
        variant_ids: sync_variant_ids
      }
    end
  end
end
