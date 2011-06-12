#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"

require File.expand_path("lib/resque_picky_worker", File.dirname(__FILE__))

Resque.redis = "localhost:6379"
p Resque::PickyWorker.pick_queue
