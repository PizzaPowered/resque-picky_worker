unless defined?(Resque::PickyWorker)
  require "resque/picky_worker"
end

Resque::Worker = Resque::PickyWorker
