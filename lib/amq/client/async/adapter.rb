# encoding: utf-8

require "amq/client/adapter"
require "amq/client/async/entity"
require "amq/client/async/channel"

module AMQ
  # For overview of AMQP client adapters API, see {AMQ::Client::Adapter}
  module Client
    module Async

      # Base adapter class. Specific implementations (for example, EventMachine-based, Cool.io-based or
      # sockets-based) subclass it and must implement Adapter API methods:
      #
      # * #send_raw(data)
      # * #establish_connection(settings)
      # * #close_connection
      #
      # @abstract
      module Adapter
        def self.included(host)
          host.send(:include, AMQ::Client::Adapter)

          host.extend(ProtocolMethodHandlers)
          host.extend(ClassMethods)
        end # self.included(host)


        #
        # Behaviours
        #

        include Callbacks

        extend RegisterEntityMixin

        register_entity :channel, AMQ::Client::Async::Channel


        module ClassMethods
        end # ClassMethods
      end # Adapter

    end # Async
  end # Client
end # AMQ
