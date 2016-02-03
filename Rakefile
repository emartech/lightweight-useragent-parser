require 'bundler/gem_tasks'

tasks = Rake.application.instance_variable_get '@tasks'
# tasks.delete 'release'

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
