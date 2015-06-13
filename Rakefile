require "rake/testtask"
require 'rspec/core/rake_task'

task :default => [:spec, :test]

RSpec::Core::RakeTask.new(:spec

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end
