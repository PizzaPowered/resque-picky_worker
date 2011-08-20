require 'bundler'
Bundler::GemHelper.install_tasks

begin
  require "spec"
rescue LoadError => e
  require "rubygems"
  require "spec"
end

begin
  require 'spec/rake/spectask'

  desc "Run all specs"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
  end
rescue LoadError => e
  puts "Warning: RSpec not found. spec task won't work until you `gem install rspec`"
end
