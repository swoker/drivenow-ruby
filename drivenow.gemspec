require File.expand_path("../lib/drivenow/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "drivenow"
  s.version = Drivenow::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Simon Woker"]
  s.email = ["github@simonwoker.de"]
  s.homepage = "http://github.com/swoker/drivenow-ruby"
  s.summary = "Wrapper for the DriveNow API"
  s.description = "Wraps the DriveNow JSON to use it nicely in your own environment. You can use this Gem to read all cars that are available."

  s.required_rubygems_version = ">= 1.3.6"

  # If you have other dependencies, add them here
  s.add_runtime_dependency "json", ["~> 1.6"]
  
  s.add_development_dependency "rake", [">= 0"]
  s.add_development_dependency "rspec", ["~>2.8"]


  # If you need to check in files that aren't .rb files, add them here
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end
