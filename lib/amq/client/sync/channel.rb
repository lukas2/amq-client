# encoding: utf-8

require "amq/client/entity"
require "amq/client/sync/queue"
require "amq/client/sync/exchange"

module AMQ
  module Client
    module Sync
      class Channel

        #
        # Behaviours
        #

        extend RegisterEntityMixin

        register_entity :queue,    AMQ::Client::Sync::Queue
        register_entity :exchange, AMQ::Client::Sync::Exchange
      end # Channel
    end # Sync
  end # Client
end # AMQ
