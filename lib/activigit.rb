require 'activigit/version'
require 'gruff'
require 'date'

module Activigit
  class Error < StandardError; end

  def self.run
    logs = ''

    Dir.chdir('/home/apprenant/arousseau/website/') do
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

    puts counts

    # date_range = (first_commit_date..last_commit_date)
    # days = date_range.uniq { |d| d }

    # puts date_range.to_a.inspect
    # puts last_commit_date

    return

    g = Gruff::Line.new
    g.title = 'Wow!  Look at this!'
    g.labels = { 0 => '5/6', 1 => '5/15', 2 => '5/24', 3 => '5/30', 4 => '6/4',
                 5 => '6/12', 6 => '6/21', 7 => '6/28' }
    g.data :Jimmy, [25, 36, 86, 39, 25, 31, 79, 88]
    g.data :Charles, [80, 54, 67, 54, 68, 70, 90, 95]
    g.data :Julie, [22, 29, 35, 38, 36, 40, 46, 57]
    g.data :Jane, [95, 95, 95, 90, 85, 80, 88, 100]
    g.data :Philip, [90, 34, 23, 12, 78, 89, 98, 88]
    g.data :Arthur, [5, 10, 13, 11, 6, 16, 22, 32]
    g.write('exciting.png')
  end
end
