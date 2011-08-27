require "resque"
require "resqueue-metadata"

module Resque
  class PickyWorker < Worker
    Error = Class.new(StandardError)

    class << self
      # Number of maximum workers to default to per queue if the queue doesn't have a maximum set
      attr_accessor :default_max_workers

      # Something that responds to #call (eg. Proc) and takes a single argument - array of queue names
      # Should return a string which is a valid queue name
      attr_accessor :chooser

      # Ignores any passed queue names and always picks a queue when set to true
      # defaults to false
      attr_accessor :force_picking_queue
    end

    # Defaults for class instance variables
    self.default_max_workers ||= 5
    self.force_picking_queue = false

    # If we invoke the chooser and one isn't set, raise an error
    def self.chooser
      @chooser || raise(Error, "chooser must be specified or I cannot choose a queue to listen to")
    end

    # Returns a string (name of a queue)
    def self.pick_queue
      cue = chooser.call(Resque.queues)
      raise(Error, "chooser returned an invalid queue name") unless Resque.queues.include?(cue)
      cue
    end

    # Create the worker class. Delegates most of the work to the superclass (Resque::Worker) after picking
    # a queue. If a queue names are passed and PickyWorker.force_picking_queue is false, then it uses the
    # passed queue names. Set PickyWorker.force_picking_queue = true to ignore any passed queue names and 
    # always pick a queue to listen on.
    def initialize(*queues)
      queues = [PickyWorker.pick_queue] if PickyWorker.force_picking_queue || queues.empty?
      super(queues)
    end

  end
end
