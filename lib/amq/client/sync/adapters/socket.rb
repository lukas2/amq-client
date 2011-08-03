# encoding: utf-8

require "socket"
require "amq/client"
require "amq/client/adapter"
require "amq/client/sync/channel"
require "amq/client/framing/io/frame"

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


        #
        # API
        #

        def initialize
          @frames = Array.new
          @username = "guest" ###
          @password = "guest" ###
        end

        def establish_connection(settings)
          # NOTE: this doesn't work with "localhost", I don't know why:
          settings[:host] = "127.0.0.1" if settings[:host] == "localhost"
          @socket         = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
          sockaddr        = Socket.pack_sockaddr_in(settings[:port], settings[:host])

          @socket.connect(sockaddr)
        rescue Errno::ECONNREFUSED => exception
          message = "Don't forget to start an AMQP broker first!\nThe original message: #{exception.message}"
          raise exception.class.new(message)
        rescue Exception => exception
          self.disconnect if self.connected?
          raise exception
        end

        def connection
          @socket
        end # connection

        def connected?
          @socket && !@socket.closed?
        end

        def close_connection
          @socket.close
        end

        def disconnection_successful
          self.close_connection # WTF, this shouldn't be required?
        end

        def send_raw(data)
          @socket.write(data)
        end

        def receive
          frame = AMQ::Client::Framing::IO::Frame.decode(@socket)
          self.receive_frame(frame)
          frame
        end

        def receive_frameset(frames)
          # puts "Frames received: #{frames.inspect}" ###
          return *frames
        end

        #
        # AMQP Methods
        #
        def handshake
          super
          self.receive # Connection.Start
          self.send_frame(AMQ::Protocol::Connection::StartOk.encode(Settings.client_properties, "PLAIN", self.encode_credentials(@username, @password), "en_GB"))
          connection_tune = self.receive.decode_payload
          self.send_frame(AMQ::Protocol::Connection::TuneOk.encode(connection_tune.channel_max, connection_tune.frame_max, connection_tune.heartbeat))
        end
      end
    end
  end
end
