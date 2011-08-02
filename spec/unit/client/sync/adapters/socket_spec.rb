# encoding: utf-8

require "spec_helper"
require "amq/client/sync/adapters/socket"

describe AMQ::Client::Sync::SocketClient do
  describe ".connect(settings = Hash.new)" do
    it "should return an instance of the SocketClient" do
      described_class.connect.should be_kind_of(described_class)
    end
  end

  describe "#channel" do
    it "should be able to create a new channel" do
      subject.channel("test").should be_kind_of(AMQ::Client::Sync::Channel)
    end
  end
end
