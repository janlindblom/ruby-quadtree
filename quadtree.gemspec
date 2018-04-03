# -*- encoding: utf-8 -*-
# stub: quadtree 1.0.5a ruby lib

Gem::Specification.new do |s|
  s.name = "quadtree".freeze
  s.version = "1.0.5a"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Lindblom".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-04-03"
  s.email = ["jan.lindblom@mittmedia.se".freeze]
  s.files = [".editorconfig".freeze, ".gitignore".freeze, ".rspec".freeze, ".travis.yml".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "bin/console".freeze, "bin/setup".freeze, "bitbucket-pipelines.yml".freeze, "lib/quadtree.rb".freeze, "lib/quadtree/axis_aligned_bounding_box.rb".freeze, "lib/quadtree/point.rb".freeze, "lib/quadtree/quadtree.rb".freeze, "lib/quadtree/version.rb".freeze, "quadtree.gemspec".freeze]
  s.homepage = "https://bitbucket.org/janlindblom/ruby-quadtree".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Quadtrees in Ruby.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.11"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_runtime_dependency(%q<version>.freeze, ["~> 1.1"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.11"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<version>.freeze, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.11"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<version>.freeze, ["~> 1.1"])
  end
end
