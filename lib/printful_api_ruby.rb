require 'printful/version'
require 'printful/configuration'
require 'printful/client'
require 'printful/error'

module Printful
  extend Configuration
  class << self
    # Alias for printful::Client.new
    #
    # @return [printful::Client]
    def new(options={})
      Printful::Client.new(options)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
