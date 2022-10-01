require_relative "lib/kisoku/version"

Gem::Specification.new do |s|
  s.name = "kisoku"
  s.version = Kisoku::VERSION
  s.summary = "A lightweight Rules Engine"
  s.description = "A gem for implementing the Rules Engine pattern"
  s.authors = ["Patrick Brown"]
  s.email = "ptrckbrwn@icloud.com"
  s.files = [
    "lib/kisoku.rb",
    "lib/kisoku/version",
    "lib/kisoku/rule.rb",
    "lib/kisoku/rules_engine.rb"
  ]
  s.homepage = "https://github.com/patrickbrown-dev/kisoku"
  s.license = "MIT"

  s.add_development_dependency "rake", "~> 13.0.6"
  s.add_development_dependency "standard", "~> 1.9.0"
  s.add_development_dependency "pry", "~> 0.13.1"
end
