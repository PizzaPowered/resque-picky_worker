require "resque"
require "resqueue-metadata"

module Resque
  class PickyWorker < Worker
    Error = Class.new(StandardError)

    class << self
      attr_accessor :default_max_workers
      # Something that responds to #call (eg. Proc) and takes a single argument - array of queue names
      # Should return a string which is a valid queue name
      attr_accessor :chooser
    end
    self.default_max_workers ||= 5

    def self.chooser
      @chooser || raise(Error, "chooser must be specified or I cannot choose a queue to listen to")
    end

    # Returns a string (name of a queue)
    def self.pick_queue
      cue = chooser.call(Resque.queues)
      raise(Error, "chooser returned an invalid queue name") unless Resque.queues.include?(cue)
      cue
    end

    # Invoke the worker class with a randomly picked queue
    def initialize(*queues)
      queues << PickyWorker.pick_queue if queues.empty?
      super(queues)
    end

  end
end
