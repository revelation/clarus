require 'bundler'
require 'bundler/gem_tasks'
require 'rake/testtask'

Bundler.setup

task :default => 'test'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end
