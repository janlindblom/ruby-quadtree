# -*- encoding: utf-8 -*-
# stub: quadtree 1.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "quadtree".freeze
  s.version = "1.0.8"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Lindblom".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-06-04"
  s.email = ["janlindblom@fastmail.fm".freeze]
  s.files = [".rubocop.yml".freeze, ".rubocop_todo.yml".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "lib/quadtree.rb".freeze, "lib/quadtree/axis_aligned_bounding_box.rb".freeze, "lib/quadtree/point.rb".freeze, "lib/quadtree/quadtree.rb".freeze, "lib/quadtree/unknown_type_error.rb".freeze, "lib/quadtree/version.rb".freeze, "quadtree.gemspec".freeze]
  s.homepage = "https://bitbucket.org/janlindblom/ruby-quadtree".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "2.7.6.2".freeze
  s.summary = "Quadtrees in Ruby.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.13"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.18"])
      s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.4"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.85"])
      s.add_runtime_dependency(%q<version>.freeze, ["~> 1.1"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 2"])
      s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.13"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.18"])
      s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.4"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.85"])
      s.add_dependency(%q<version>.freeze, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 2"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.13"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.18"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.4"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.85"])
    s.add_dependency(%q<version>.freeze, ["~> 1.1"])
  end
end
