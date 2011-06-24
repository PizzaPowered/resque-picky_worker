require "spec_helper"

describe Resque::PickyWorker do
  before do
    @odd_queues = %w(process analysis)
    @crawl_queues = %w(crawl_1_caius.name crawl_2_caius.name crawl_2_swedishcampground.com)
    @queues = @odd_queues | @crawl_queues
    Resque.stub!(:queues).and_return(@queues)
  end

  describe ".pick_queue" do
    before do
      @queue = Resque::PickyWorker.pick_queue
    end
    it "returns a string" do
      @queue.should be_a(String)
    end
    it "should be a crawl queue" do
      @crawl_queues.should include(@queue)
    end
  end

  describe ".queue_max" do
    context "with a max count set" do
      it "should return it" do
        Resque::Queue::Metadata.new("testing-queue-name-here")["max_workers"]
      end
    end
  end

end
