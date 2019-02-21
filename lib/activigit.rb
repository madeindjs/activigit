require 'activigit/version'
require 'gruff'
require 'date'

module Activigit
  class Error < StandardError; end

  class Repository
    def initialize(path)
      @path = path
    end

    def group_by_days
      group_with_format '%Y-%m-%d'
    end

    def group_by_months
      group_with_format '%Y-%m'
    end

    def group_with_format(format)
      logs = ''
      Dir.chdir(@path) do
        logs = `git log --branches --format=%cI`.split("\n")
      end

      logs_grouped = logs.group_by { |log| Date.parse(log).strftime(format) }

      last_commit_date = Date.parse logs.first
      current_date = Date.parse logs.last

      counts = {}

      while current_date != last_commit_date
        current_date_str = current_date.strftime(format)
        counts[current_date_str] = if logs_grouped[current_date_str].nil?
                                     0
                                   else
                                     logs_grouped[current_date_str].count
                                   end

        current_date += 1
      end

      g = Gruff::Line.new
      g.title = 'Wow!  Look at this!'
      # transform `['a', 'b', 'c']` into `{0=>'a', 1=>'b', 2=>'c'}`
      g.labels = counts.map.with_index { |k, i| [i, k.first] }.to_h
      g.data :commits, counts.values
      g.write('exciting.png')
    end
  end
end
