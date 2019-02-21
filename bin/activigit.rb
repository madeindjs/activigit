#!/usr/bin/ruby
require 'activigit'

folder = ARGV.first

if folder.nil? || folder.empty?
  warn 'Please provide a Git repository'
  exit 1
end

Activigit.by_months folder
