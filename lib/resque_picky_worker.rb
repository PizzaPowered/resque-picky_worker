require "resque"
require "resqueue-metadata"

module Resque
  class PickyWorker < Worker

    # Returns a string (name of a queue)
    def self.pick_queue
      Resque.queues.select {|s| s[/\Acrawl_/] }.shuffle.first
    end

    

  end
end
