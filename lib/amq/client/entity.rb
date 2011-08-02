# encoding: utf-8

require "amq/client/openable"

module AMQ
  module Client
    module RegisterEntityMixin
      # @example Registering Channel implementation
      #  Adapter.register_entity(:channel, Channel)
      #   # ... so then I can do:
      #  channel = client.channel(1)
      #  # instead of:
      #  channel = Channel.new(client, 1)
      def register_entity(name, klass)
        define_method(name) do |*args, &block|
          klass.new(self, *args, &block)
        end # define_method
      end # register_entity
    end # RegisterEntityMixin


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

      include Openable

      #
      # API
      #

      def initialize(connection)
        @connection = connection
      end # initialize
    end # Entity
  end # Client
end # AMQ
