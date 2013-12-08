#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  desc 'Removes the temporary testing app for a clean test suite.'
  task :clean do
    FileUtils.rm_rf('./tmp/app', :verbose => true)
    Rake::Task[:spec].invoke
  end
end
task :default => :spec
