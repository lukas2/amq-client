# encoding: utf-8

require "amq/client/entity"
require "amq/client/async/callbacks"

module AMQ
  module Client
    module Async
      module ProtocolMethodHandlers
        def handle(klass, &block)
          AMQ::Client::HandlersRegistry.register(klass, &block)
        end

        def handlers
          AMQ::Client::HandlersRegistry.handlers
        end
      end # ProtocolMethodHandlers


      # AMQ entities, as implemented by AMQ::Client, have callbacks and can run them
      # when necessary.
      #
      # @note Exchanges and queues implementation is based on this class.
      #
      # @abstract
      module Entity

        #
        # Behaviours
        #

        include AMQ::Client::Entity
        include Async::Callbacks

        #
        # API
        #

        # @return [Array<#call>]
        attr_reader :callbacks


        def initialize(connection)
          # Be careful with default values for #ruby hashes: h = Hash.new(Array.new); h[:key] ||= 1
          # won't assign anything to :key. MK.
          @callbacks  = Hash.new

          super(connection)
        end # initialize
      end # Entity
    end # Async
  end # Client
end # AMQ
