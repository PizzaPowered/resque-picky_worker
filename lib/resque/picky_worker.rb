require "resque"
require "resqueue-metadata"

module Resque
  class PickyWorker < Worker
    DEFAULT_MAX_WORKERS = 5

    # Returns a string (name of a queue)
    def self.pick_queue
      Resque.queues.select do |s|
        # It's a crawl_* queue and has free worker slots available
        s[/\Acrawl_/] && (queue_max(s) > queue_current(s)) # && jobs available (above certain threshold?)
      end.shuffle.first # pick one at random
    end

    def self.queue_max name
      (Resque::Queue::Metadata.new(name)["max_workers"] || DEFAULT_MAX_WORKERS).to_i
    end
    
    def self.queue_current name
      all.select {|worker| worker.queues.include?(name) }.size
    end

    # Invoke the worker class with a randomly picked queue
    def initialize
      super(PickyWorker.pick_queue)
    end

  end
end
