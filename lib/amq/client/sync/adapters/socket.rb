# encoding: utf-8

require "amq/client/adapter"
require "amq/client/sync/channel"

module AMQ
  module Client
    module Sync
      class SocketClient

        #
        # Behaviours
        #

        include AMQ::Client::Adapter
        
        extend RegisterEntityMixin

        register_entity :channel, AMQ::Client::Sync::Channel
      end
    end
  end
end
