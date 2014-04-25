#!/usr/bin/env rake

ENV['RACK_ENV'] ||= 'test'
require 'bk/gem/minitest/load_test_rake_files' if ENV['RACK_ENV'].downcase == 'test'

desc 'Run Specs'
task :default => :test
