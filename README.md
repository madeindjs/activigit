# Activigit

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/activigit`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

~~~bash
$ sudo apt-get install libmagickwand-dev imagemagick
$ gem install activigit
~~~

## Usage

~~~
Draw an activity graph for the given Git golder

Usage: activigit.rb [options] <git_folder_path>
    -b, --group_by=FIELD             Counts commit by months or days
                                     possibles values are `months` or `days`
    -f, --group_by_format=FORMAT     Counts commit by given date format
    -h, --help                       Display this message
~~~


~~~bash
$ activigit.rb ~/gitea/isignif/website/
~~~

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madeindjs/activigit.
