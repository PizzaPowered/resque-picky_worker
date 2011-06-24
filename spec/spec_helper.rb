require File.expand_path("../lib/resque/picky_worker", File.dirname(__FILE__))

Resque.redis = "localhost:6379"
Resque.redis.namespace = "resque-picky-worker-spec"
