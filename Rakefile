require 'rake'
require 'rake/testtask'

task :default => [:'test:units']

desc "Run unit tests"
Rake::TestTask.new("test:units") do |t|
  t.pattern = 'test/*_test.rb'
  t.warning = true
end
