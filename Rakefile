lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rake/version_task"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"
require "yard/rake/yardoc_task"
require 'rubocop/rake_task'
require "quadtree"

RSpec::Core::RakeTask.new(:spec)

spec = Gem::Specification.new do |s|
  s.name          = "quadtree"
  s.version       = Quadtree::VERSION
  s.authors       = ["Jan Lindblom"]
  s.email         = ["janlindblom@fastmail.fm"]

  s.summary       = %q{Quadtrees in Ruby.}
  s.homepage      = "https://bitbucket.org/janlindblom/ruby-quadtree"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(bin|test|spec|features)/}) ||
    f == ".travis.yml" ||
    f == "bitbucket-pipelines.yml" ||
    f == "buildspec.yml"
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 2.3.0'

  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "pry", "~> 0.11"
  s.add_development_dependency "yard", "~> 0.9"
  s.add_development_dependency "simplecov", "~> 0.16"
  s.add_runtime_dependency "version", "~> 1.1"
end

Rake::VersionTask.new do |task|
  task.with_gemspec = spec
  task.with_git = false
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
end

RuboCop::RakeTask.new

task :default => :spec
