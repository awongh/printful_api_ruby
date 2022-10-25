# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Printful do
  after do
    Printful.reset
  end

  describe ".respond_to?" do
    it "should be true if method exists" do
      Printful.respond_to?(:new, true).should be true
    end
  end

  describe ".new" do
    it "should be a Printful::Client" do
      Printful.new.should be_a Printful::Client
    end
  end

end
