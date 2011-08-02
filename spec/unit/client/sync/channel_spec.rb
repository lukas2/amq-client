# encoding: utf-8

require "spec_helper"
require "amq/client/sync/channel"

describe AMQ::Client::Sync::Channel do
  describe "#queue" do
    it "should be able to create a new queue" do
      subject.queue("test").should be_kind_of(AMQ::Client::Sync::Queue)
    end
  end

  describe "#exchange" do
    it "should be able to create a new exchange" do
      subject.exchange("test").should be_kind_of(AMQ::Client::Sync::Exchange)
    end
  end
end
