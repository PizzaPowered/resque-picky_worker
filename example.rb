#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
$:.unshift File.expand_path("lib", File.dirname(__FILE__))

require "resque/picky_worker/override"

# Try not to trample on other things in redis
Resque.redis.namespace = "example:pickyworker"

# Make sure we've got some queues to choose from
Resque.redis.del "queues"
%w(1 2 3 4).each do |x|
  Resque.redis.sadd "queues", x
end

# Define how to choose a queue, we'll go for the max integer one
Resque::Worker.chooser = lambda do |queues|
  queues.map(&:to_i).select {|i| i % 2 == 0 }.max.to_s
end

Resque::Worker.pick_queue # => "4"
