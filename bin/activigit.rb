#!/usr/bin/ruby
require 'activigit'
require 'optparse'

folder = ARGV.first

method = 'group_by_months'
format = nil

options = {}
OptionParser.new do |opts|
  opts.banner = "Draw an activity graph for the given Git golder\n\nUsage: activigit.rb [options] <git_folder_path>"

  opts.on('-bNAME', '--group_by=FIELD', 'Counts commit by months or days', 'possibles values are `months` or `days` ') do |n|
    method = "group_by_#{n}"
  end

  opts.on('-fNAME', '--group_by_format=FORMAT', 'Counts commit by given date format') do |f|
    format = f
  end

  opts.on('-h', '--help', 'Display this message') do
    puts opts
    exit
  end

  if folder.nil? || folder.empty?
    warn 'Please provide a Git repository'
    warn opts
    exit 1
  end
end.parse!

if format.nil?
  Activigit::Repository.new(folder).send method
else
  Activigit::Repository.new(folder).group_with_format format
end
