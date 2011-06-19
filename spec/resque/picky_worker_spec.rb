require "spec_helper"

describe Resque::PickyWorker do
  before do
    Resque.stub!(:queue).and_return(%w(process analysis crawl_1_caius.name crawl_2_caius.name crawl_2_swedishcampground.com))
  end

  describe ".pick_queue" do
    before do
      @queue = Resque::PickyWorker.pick_queue
    end
    it "returns a string" do
      @queue.should be_a(String)
    end
    it "should be a crawl url" do
      @queue.should =~ /^crawl_/
    end
  end

end
