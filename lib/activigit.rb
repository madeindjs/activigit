require 'activigit/version'
require 'gruff'
require 'date'

module Activigit
  class Error < StandardError; end

  def self.by_days(folder)
    logs = ''

    Dir.chdir(folder) do
      logs = `git log --branches --format=%cI`.split("\n")
    end

    logs_grouped = logs.group_by { |log| Date.parse(log).strftime('%Y-%m-%d') }

    # logs_grouped.each { |x, y| print "#{x} #{y.size}\n" }

    last_commit_date = Date.parse logs.first
    current_date = Date.parse logs.last

    counts = {}

    while current_date != last_commit_date

      current_date_str = current_date.strftime('%Y-%m-%d')

      counts[current_date_str] = if logs_grouped[current_date_str].nil?
                                   0
                                 else
                                   logs_grouped[current_date_str].count
                                 end

      current_date += 1

    end

    # puts counts

    # date_range = (first_commit_date..last_commit_date)
    # days = date_range.uniq { |d| d }

    # puts date_range.to_a.inspect
    # puts last_commit_date

    # return

    g = Gruff::Line.new
    g.title = 'Wow!  Look at this!'
    # transform `['a', 'b', 'c']` into `{0=>'a', 1=>'b', 2=>'c'}`
    g.labels = counts.map.with_index { |k, i| [i, k] }.to_h
    g.data :commits, counts.values
    g.write('exciting.png')
  end
end
