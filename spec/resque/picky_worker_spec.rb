require "spec_helper"

describe Resque::PickyWorker do
  before do
    @odd_queues = %w(1 3)
    @even_queues = %w(2 4 6)
    @queues = @odd_queues | @even_queues
    Resque.stub!(:queues).and_return(@queues)

    @chooser = lambda do |queues|
      # Choose the highest even numbered queue we can find
      queues.map(&:to_i).select {|i| i % 2 == 0 }.max.to_s
    end
    Resque::PickyWorker.chooser = @chooser
  end

  describe ".pick_queue" do
    before do
      @queue = Resque::PickyWorker.pick_queue
    end
    it "returns a string" do
      @queue.should be_a(String)
    end
    it "should be a crawl queue" do
      @even_queues.should include(@queue)
    end
  end

  describe ".chooser" do
    it "should be required" do
      Resque::PickyWorker.chooser = nil

      lambda do
        Resque::PickyWorker.chooser
      end.should raise_error(Resque::PickyWorker::Error, "chooser must be specified or I cannot choose a queue to listen to")
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
