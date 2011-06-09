require 'bundler/gem_tasks'
require 'rake/testtask'
require 'bundler'

Bundler.setup

Rake::TestTask.new do |t|
  #ENV['JAVA_OPTS'] = "-d32"
  t.pattern = "spec/*_spec.rb"
end

#task :default do
#  `JAVA_OPTS="-d32" bundle exec ruby ./spec/junodoc_spec.rb`
#  `JAVA_OPTS="-d32" rake test`
#end
