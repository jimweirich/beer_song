#!/usr/bin/env ruby

require 'rake/clean'
require 'rake/testtask'

task :default => [:spec, :test]

task :spec do
  sh "rspec ."
end

task :test do
  ruby "beer_song_test.rb"
end
