# encoding: utf-8

require "spec_helper"
require "amq/client/sync/adapters/socket"

describe AMQ::Client::Sync::SocketClient do
  describe ".connect(settings = Hash.new)" do
    it "should return an instance of the SocketClient" do
      described_class.connect.should be_kind_of(described_class)
    end

    it "should take settings as an argument" do
      lambda {
        described_class.connect(:host => "localhost")
      }.should_not raise_error(ArgumentError)
    end
  end

  describe "#channel" do
    it "should be able to create a new channel" do
      subject.channel("test").should be_kind_of(AMQ::Client::Sync::Channel)
    end
  end

  describe "#connected?" do
    it "should return true after we connect" do
      instance = described_class.connect
      instance.should be_connected
    end

    it "should return false after we disconnect" do
      instance = described_class.connect
      instance.disconnect
      instance.should_not be_connected
    end
  end

  describe "#handshake" do
    subject do
      instance = described_class.new
      instance.establish_connection(:host => "localhost", :port => AMQ::Protocol::DEFAULT_PORT)
      instance
    end

    it "should establish the connection with the broker" do
      subject.handshake
    end
  end
end
