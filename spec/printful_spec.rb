# frozen_string_literal: true

require 'spec_helper'

describe Printful do
  after do
    Printful.reset
  end

  describe ".respond_to?" do
    it "should be true if method exists" do
      expect(Printful.respond_to?(:new, true)).to eq(true)
    end
  end

  describe ".new" do
    it "should be a Printful::Client" do
      expect(Printful.new).to be_a(Printful::Client)
    end
  end
end
