#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
    t.libs << 'lib/eventfabric'
    t.test_files = FileList['test/lib/eventfabric/*_test.rb']
    t.verbose = true
end

task :default => :test
