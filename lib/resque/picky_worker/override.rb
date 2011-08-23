unless defined?(Resque::PickyWorker)
  require "resque/picky_worker"
end

# Swap this stuff out without generating a warning
original_verbosity, $VERBOSE = $VERBOSE, nil
Resque::Worker = Resque::PickyWorker
$VERBOSE, original_verbosity = original_verbosity, nil
