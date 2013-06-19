#!/usr/bin/env rake
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new
task :default => :spec
task :test => :spec

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks
