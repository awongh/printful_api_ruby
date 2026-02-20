# frozen_string_literal: true

require 'printful/version'
require 'printful/configuration'
require 'printful/client'
require 'printful/error'

module Printful
  extend Configuration
  class << self
    # Alias for Printful::Client.new
    #
    # @return [Printful::Client]
    def new(options = {})
      Printful::Client.new(options)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
