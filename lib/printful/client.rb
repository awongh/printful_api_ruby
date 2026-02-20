# frozen_string_literal: true

require 'printful/configuration'
require 'printful/connection'
require 'printful/request'
require 'printful/error'

module Printful
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS, :connection_options)

    def initialize(options = {}, connection_options = {})
      self.connection_options = connection_options

      options = Printful.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Printful::Configuration
    include Printful::Connection
    include Printful::Request
  end
end
