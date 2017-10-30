# Speedtest

Tiny speedtest.net command line tool in ruby.
Heavily inspired by [speedtest.rb](https://github.com/lacostej/speedtest.rb)

## Installation


```ruby
gem 'speedtest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install speedtest

## Usage

Simple tty check Internet speed

```sh
speedtest check
```
Output speed for other usage

```sh
speedtest check --json
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dylandy/speedtest.

## Reference

- https://github.com/lacostej/speedtest.rb
- https://github.com/fopina/pyspeedtest
- https://www.phuket-data-wizards.com/blog/2011/09/17/speedtest-vs-dslreports-analysis/
- https://iamhow.com//Tools_and_Scripts/Run_Speedtest_from_command_line.html

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
