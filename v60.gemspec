require_relative "lib/v60/version"

Gem::Specification.new do |s|
  s.name = "v60"
  s.version = V60::VERSION
  s.summary = "A lightweight Rules Engine"
  s.description = "A gem for implementing the Rules Engine pattern"
  s.authors = ["Patrick Brown"]
  s.email = "hello@patrickbrown.dev"
  s.files = [
    "lib/v60.rb",
    "lib/v60/version"
  ]
  s.homepage = "https://github.com/patrickbrown-dev/V60"
  s.license = "MIT"

  s.add_development_dependency "rake", "~> 13.0.6"
  s.add_development_dependency "minitest", "~> 5.16.3"
  s.add_development_dependency "standard", "~> 1.9.0"
  s.add_development_dependency "pry", "~> 0.13.1"
end
