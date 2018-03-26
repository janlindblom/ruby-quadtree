# Quadtree

[![Gem Version](https://badge.fury.io/rb/quadtree.svg)](https://badge.fury.io/rb/quadtree)

Quadtrees in Ruby. For searching spatially related nodes in some space, you know.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quadtree'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quadtree

## Usage

Load it in your code to start building quadtrees:

```ruby
require 'quadtree'

boundary = Quadtree::AxisAlignedBoundingBox.new(Quadtree::Point.new(19.8470050, 60.3747940), 8944.0)
qt = Quadtree::Quadtree.new(boundary)
```

Then you can do lookups and such:

```ruby
getaboden = Quadtree::Point.new(19.8470050, 60.3747940, "Getaboden")
knutnas = Quadtree::Point.new(19.8271170, 60.3505570, "Knutnäs")
boundary = Quadtree::AxisAlignedBoundingBox.new(Quadtree::Point.new(19.8470050, 60.3747940), 8944.0)
boundary2 = Quadtree::AxisAlignedBoundingBox.new(Quadtree::Point.new(19.8470050, 60.3747940), 4472.0)
qt.insert! getaboden
qt.insert! knutnas
qt.query_range(boundary2)
# [#<Quadtree::Point:0x00007fdcb19e0698 @data="Getaboden", @x=19.847005, @y=60.374794>,
 #<Quadtree::Point:0x00007fdcb19ec7b8 @data="Knutnäs", @x=19.827117, @y=60.350557>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucket at https://bitbucket.org/janlindblom/ruby-quadtree. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Quadtree project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/quadtree/blob/master/CODE_OF_CONDUCT.md).
