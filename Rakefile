require 'rake'
require 'rake/testtask'
require 'bundler'

task :default => [:'test:units']

desc "Run unit tests"
Rake::TestTask.new("test:units") do |t|
	Bundler.setup(:test)
  t.pattern = 'test/*_test.rb'
  t.warning = true
end
